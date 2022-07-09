// Copyright (C) Martin Wetzko
// See the LICENSE file in the project root for more information

using System;
using System.IO;

namespace EnumDependencies
{
    unsafe static class Program
    {
        static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                string filename = args[0];

                if (File.Exists(filename))
                {
                    if (filename.EndsWith(".dll", System.StringComparison.InvariantCultureIgnoreCase) ||
                        filename.EndsWith(".exe", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        using (FileStream fs = new FileStream(filename, FileMode.Open, FileAccess.Read, FileShare.Read))
                        {
                            byte[] data = new byte[fs.Length];

                            fs.Read(data, 0, data.Length);

                            fixed (byte* b = data)
                            {
                                EnumDependencies((IntPtr)b);
                            }

                            fs.Position = 0;

                            fs.Write(data, 0, data.Length);
                        }
                    }
                }
            }
        }

        static void EnumDependencies(IntPtr mmv)
        {
            IMAGE_DOS_HEADER* dos = (IMAGE_DOS_HEADER*)mmv;

            if (dos->e_magic != Win32.IMAGE_DOS_SIGNATURE)
            {
                return;
            }

            IMAGE_NT_HEADERS* header = (IMAGE_NT_HEADERS*)((byte*)dos + dos->e_lfanew);

            if (header->Signature != Win32.PE_SIGNATURE)
            {
                return;
            }

            if (header->FileHeader.Machine != Win32.IMAGE_FILE_MACHINE_I386 &&
                header->FileHeader.Machine != Win32.IMAGE_FILE_MACHINE_AMD64)
            {
                // for now we only support x86 and amd64
                return;
            }

            if (header->FileHeader.Machine == Win32.IMAGE_FILE_MACHINE_I386)
            {
                IMAGE_NT_HEADERS32* nt32 = (IMAGE_NT_HEADERS32*)((byte*)dos + dos->e_lfanew);

                if (nt32->OptionalHeader.DataDirectory1.Size == 0)
                {
                    // does not have imports
                    return;
                }

                IMAGE_SECTION_HEADER* firstSection = (IMAGE_SECTION_HEADER*)((byte*)(&nt32->OptionalHeader) + nt32->FileHeader.SizeOfOptionalHeader);

                EnumPeDependencies(dos, firstSection, nt32->FileHeader.NumberOfSections, nt32->OptionalHeader.DataDirectory1.VirtualAddress);
            }
            else
            {
                IMAGE_NT_HEADERS64* nt64 = (IMAGE_NT_HEADERS64*)((byte*)dos + dos->e_lfanew);

                if (nt64->OptionalHeader.DataDirectory1.Size == 0)
                {
                    // does not have imports
                    return;
                }

                IMAGE_SECTION_HEADER* firstSection = (IMAGE_SECTION_HEADER*)((byte*)(&nt64->OptionalHeader) + nt64->FileHeader.SizeOfOptionalHeader);

                EnumPeDependencies(dos, firstSection, nt64->FileHeader.NumberOfSections, nt64->OptionalHeader.DataDirectory1.VirtualAddress);
            }
        }

        static void EnumPeDependencies(IMAGE_DOS_HEADER* dos, IMAGE_SECTION_HEADER* firstSection, uint numberOfSections, uint importDirAddress)
        {
            for (int i = 0; i < numberOfSections; i++)
            {
                if (firstSection[i].VirtualAddress <= importDirAddress && importDirAddress < firstSection[i].VirtualAddress + firstSection[i].Misc.VirtualSize)
                {
                    EnumPeImportDirectory(dos, &firstSection[i], importDirAddress);
                    break;
                }
            }
        }

        static void EnumPeImportDirectory(IMAGE_DOS_HEADER* dos, IMAGE_SECTION_HEADER* sectionHeader, uint importDirAddress)
        {
            IMAGE_IMPORT_DESCRIPTOR* imports = (IMAGE_IMPORT_DESCRIPTOR*)((byte*)dos + sectionHeader->PointerToRawData + importDirAddress - sectionHeader->VirtualAddress);

            IMAGE_IMPORT_DESCRIPTOR* current = imports;

            while (current->Characteristics.Characteristics != 0)
            {
                uint offset = current->Name - importDirAddress;
                Console.WriteLine(new string((sbyte*)((byte*)imports + offset)));
                current++;
            }
        }
    }
}
