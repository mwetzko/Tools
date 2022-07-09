// Copyright (C) Martin Wetzko
// See the LICENSE file in the project root for more information

using System;
using System.Runtime.InteropServices;

namespace MousePositionHandleInfo
{
    unsafe static class Win32
    {
        public const uint WM_KEYDOWN = 0x0100;
        public const uint WM_SYSKEYDOWN = 0x0104;

        public const int WH_KEYBOARD_LL = 13;
        public const int WH_MOUSE_LL = 14;

        public const uint GA_PARENT = 1;

        public const uint GW_OWNER = 4;

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "SetWindowsHookExW")]
        public static extern IntPtr SetWindowsHookEx(int idHook, LowLevelMouseProcDelegate lpfn, IntPtr hMod, uint dwThreadId);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "SetWindowsHookExW")]
        public static extern IntPtr SetWindowsHookEx(int idHook, LowLevelKeyboardProcDelegate lpfn, IntPtr hMod, uint dwThreadId);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "UnhookWindowsHookEx")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool UnhookWindowsHookEx(IntPtr hHook);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "CallNextHookEx")]
        public static extern int CallNextHookEx(IntPtr hHook, int nCode, IntPtr wParam, MSLLHOOKSTRUCT* lParam);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "CallNextHookEx")]
        public static extern int CallNextHookEx(IntPtr hHook, int nCode, IntPtr wParam, KBDLLHOOKSTRUCT* lParam);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "WindowFromPoint")]
        public static extern IntPtr WindowFromPoint(POINT Point);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetWindowTextW")]
        public static extern int GetWindowText(IntPtr hWnd, char* lpString, int nMaxCount);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetWindowTextLengthW")]
        public static extern int GetWindowTextLength(IntPtr hWnd);

        public static string GetWindowText(IntPtr hWnd)
        {
            int num = GetWindowTextLength(hWnd);

            fixed (char* c = new char[num + 1])
            {
                return new string(c, 0, GetWindowText(hWnd, c, num + 1));
            }
        }

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetAncestor")]
        public static extern IntPtr GetAncestor(IntPtr hwnd, uint gaFlags);

        public static IntPtr GetParentHandle(IntPtr hWnd)
        {
            // not using GetParent(HWND), because it will return either parent or owner

            IntPtr parent = GetAncestor(hWnd, GA_PARENT);

            return (parent == IntPtr.Zero || parent == GetDesktopWindow()) ? IntPtr.Zero : parent;
        }

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetDesktopWindow")]
        public static extern IntPtr GetDesktopWindow();

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetWindow")]
        public static extern IntPtr GetWindow(IntPtr hWnd, uint uCmd);

        [DllImport("User32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, EntryPoint = "GetWindowThreadProcessId")]
        public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
    }

    [StructLayout(LayoutKind.Sequential)]
    struct POINT
    {
        public int x;
        public int y;
    }

    [StructLayout(LayoutKind.Sequential)]
    struct MSLLHOOKSTRUCT
    {
        public POINT pt;
        public uint mouseData;
        public uint flags;
        public uint time;
        public UIntPtr dwExtraInfo;
    }

    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    unsafe delegate int LowLevelMouseProcDelegate(int nCode, IntPtr wParam, MSLLHOOKSTRUCT* lParam);

    [StructLayout(LayoutKind.Sequential)]
    struct KBDLLHOOKSTRUCT
    {
        public uint vkCode;
        public uint scanCode;
        public uint flags;
        public uint time;
        public UIntPtr dwExtraInfo;
    }

    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    unsafe delegate int LowLevelKeyboardProcDelegate(int nCode, IntPtr wParam, KBDLLHOOKSTRUCT* lParam);
}
