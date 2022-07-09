// Copyright (C) Martin Wetzko
// See the LICENSE file in the project root for more information

using System.Runtime.InteropServices;

namespace EnumDependencies
{
    static class Win32
    {
        public const ushort IMAGE_DOS_SIGNATURE = 0x5A4D;      // MZ

        public const uint PE_SIGNATURE = 17744; // PE\0\0

        public const ushort IMAGE_FILE_MACHINE_I386 = 0x014c;  // Intel 386.
        public const ushort IMAGE_FILE_MACHINE_AMD64 = 0x8664; // AMD64 (K8)
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_DOS_HEADER
    {
        public ushort e_magic;
        public ushort e_cblp;
        public ushort e_cp;
        public ushort e_crlc;
        public ushort e_cparhdr;
        public ushort e_minalloc;
        public ushort e_maxalloc;
        public ushort e_ss;
        public ushort e_sp;
        public ushort e_csum;
        public ushort e_ip;
        public ushort e_cs;
        public ushort e_lfarlc;
        public ushort e_ovno;
        public E_RES e_res;
        public ushort e_oemid;
        public ushort e_oeminfo;
        public E_RES2 e_res2;
        public int e_lfanew;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct E_RES
    {
        public ushort e_res_0;
        public ushort e_res_1;
        public ushort e_res_2;
        public ushort e_res_3;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct E_RES2
    {
        public ushort e_res2_0;
        public ushort e_res2_1;
        public ushort e_res2_2;
        public ushort e_res2_3;
        public ushort e_res2_4;
        public ushort e_res2_5;
        public ushort e_res2_6;
        public ushort e_res2_7;
        public ushort e_res2_8;
        public ushort e_res2_9;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_NT_HEADERS
    {
        public uint Signature;
        public IMAGE_FILE_HEADER FileHeader;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_NT_HEADERS32
    {
        public uint Signature;
        public IMAGE_FILE_HEADER FileHeader;
        public IMAGE_OPTIONAL_HEADER32 OptionalHeader;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_NT_HEADERS64
    {
        public uint Signature;
        public IMAGE_FILE_HEADER FileHeader;
        public IMAGE_OPTIONAL_HEADER64 OptionalHeader;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_FILE_HEADER
    {
        public ushort Machine;
        public ushort NumberOfSections;
        public uint TimeDateStamp;
        public uint PointerToSymbolTable;
        public uint NumberOfSymbols;
        public ushort SizeOfOptionalHeader;
        public ushort Characteristics;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_OPTIONAL_HEADER32
    {
        public ushort Magic;
        public byte MajorLinkerVersion;
        public byte MinorLinkerVersion;
        public uint SizeOfCode;
        public uint SizeOfInitializedData;
        public uint SizeOfUninitializedData;
        public uint AddressOfEntryPoint;
        public uint BaseOfCode;
        public uint BaseOfData;
        public uint ImageBase;
        public uint SectionAlignment;
        public uint FileAlignment;
        public ushort MajorOperatingSystemVersion;
        public ushort MinorOperatingSystemVersion;
        public ushort MajorImageVersion;
        public ushort MinorImageVersion;
        public ushort MajorSubsystemVersion;
        public ushort MinorSubsystemVersion;
        public uint Win32VersionValue;
        public uint SizeOfImage;
        public uint SizeOfHeaders;
        public uint CheckSum;
        public ushort Subsystem;
        public ushort DllCharacteristics;
        public uint SizeOfStackReserve;
        public uint SizeOfStackCommit;
        public uint SizeOfHeapReserve;
        public uint SizeOfHeapCommit;
        public uint LoaderFlags;
        public uint NumberOfRvaAndSizes;
        public IMAGE_DATA_DIRECTORY DataDirectory0;
        public IMAGE_DATA_DIRECTORY DataDirectory1;
        public IMAGE_DATA_DIRECTORY DataDirectory2;
        public IMAGE_DATA_DIRECTORY DataDirectory3;
        public IMAGE_DATA_DIRECTORY DataDirectory4;
        public IMAGE_DATA_DIRECTORY DataDirectory5;
        public IMAGE_DATA_DIRECTORY DataDirectory6;
        public IMAGE_DATA_DIRECTORY DataDirectory7;
        public IMAGE_DATA_DIRECTORY DataDirectory8;
        public IMAGE_DATA_DIRECTORY DataDirectory9;
        public IMAGE_DATA_DIRECTORY DataDirectory10;
        public IMAGE_DATA_DIRECTORY DataDirectory11;
        public IMAGE_DATA_DIRECTORY DataDirectory12;
        public IMAGE_DATA_DIRECTORY DataDirectory13;
        public IMAGE_DATA_DIRECTORY DataDirectory14;
        public IMAGE_DATA_DIRECTORY DataDirectory15;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_OPTIONAL_HEADER64
    {
        public ushort Magic;
        public byte MajorLinkerVersion;
        public byte MinorLinkerVersion;
        public uint SizeOfCode;
        public uint SizeOfInitializedData;
        public uint SizeOfUninitializedData;
        public uint AddressOfEntryPoint;
        public uint BaseOfCode;
        public ulong ImageBase;
        public uint SectionAlignment;
        public uint FileAlignment;
        public ushort MajorOperatingSystemVersion;
        public ushort MinorOperatingSystemVersion;
        public ushort MajorImageVersion;
        public ushort MinorImageVersion;
        public ushort MajorSubsystemVersion;
        public ushort MinorSubsystemVersion;
        public uint Win32VersionValue;
        public uint SizeOfImage;
        public uint SizeOfHeaders;
        public uint CheckSum;
        public ushort Subsystem;
        public ushort DllCharacteristics;
        public ulong SizeOfStackReserve;
        public ulong SizeOfStackCommit;
        public ulong SizeOfHeapReserve;
        public ulong SizeOfHeapCommit;
        public uint LoaderFlags;
        public uint NumberOfRvaAndSizes;
        public IMAGE_DATA_DIRECTORY DataDirectory0;
        public IMAGE_DATA_DIRECTORY DataDirectory1;
        public IMAGE_DATA_DIRECTORY DataDirectory2;
        public IMAGE_DATA_DIRECTORY DataDirectory3;
        public IMAGE_DATA_DIRECTORY DataDirectory4;
        public IMAGE_DATA_DIRECTORY DataDirectory5;
        public IMAGE_DATA_DIRECTORY DataDirectory6;
        public IMAGE_DATA_DIRECTORY DataDirectory7;
        public IMAGE_DATA_DIRECTORY DataDirectory8;
        public IMAGE_DATA_DIRECTORY DataDirectory9;
        public IMAGE_DATA_DIRECTORY DataDirectory10;
        public IMAGE_DATA_DIRECTORY DataDirectory11;
        public IMAGE_DATA_DIRECTORY DataDirectory12;
        public IMAGE_DATA_DIRECTORY DataDirectory13;
        public IMAGE_DATA_DIRECTORY DataDirectory14;
        public IMAGE_DATA_DIRECTORY DataDirectory15;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_DATA_DIRECTORY
    {
        public uint VirtualAddress;
        public uint Size;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_SECTION_HEADER
    {
        public IMAGE_SIZEOF_SHORT_NAME Name;
        public IMAGE_SECTION_HEADER_MISC Misc;
        public uint VirtualAddress;
        public uint SizeOfRawData;
        public uint PointerToRawData;
        public uint PointerToRelocations;
        public uint PointerToLinenumbers;
        public ushort NumberOfRelocations;
        public ushort NumberOfLinenumbers;
        public uint Characteristics;
    }

    [StructLayout(LayoutKind.Sequential, Size = 8)]
    public struct IMAGE_SIZEOF_SHORT_NAME
    {
        // nothing
    }

    [StructLayout(LayoutKind.Explicit)]
    public struct IMAGE_SECTION_HEADER_MISC
    {
        [FieldOffset(0)]
        public uint PhysicalAddress;
        [FieldOffset(0)]
        public uint VirtualSize;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct IMAGE_IMPORT_DESCRIPTOR
    {
        public IMAGE_IMPORT_DESCRIPTOR_CHARACTERISTICS Characteristics;
        public uint TimeDateStamp;
        public uint ForwarderChain;
        public uint Name;
        public uint FirstThunk;
    }

    [StructLayout(LayoutKind.Explicit)]
    public struct IMAGE_IMPORT_DESCRIPTOR_CHARACTERISTICS
    {
        [FieldOffset(0)]
        public uint Characteristics;
        [FieldOffset(0)]
        public uint OriginalFirstThunk;
    }
}
