// Copyright (C) Martin Wetzko
// See the LICENSE file in the project root for more information

using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace MousePositionHandleInfo
{
    unsafe static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            using (MainForm form = new MainForm())
            {
                bool ctrlDown = false;

                var procMouse = new LowLevelMouseProcDelegate((nCode, wParam, lParam) =>
                {
                    if (nCode >= 0 && ctrlDown)
                    {
                        form.UpdateMouseData(lParam->pt.x, lParam->pt.y);
                    }

                    return Win32.CallNextHookEx(IntPtr.Zero, nCode, wParam, lParam);
                });

                var procKeyboard = new LowLevelKeyboardProcDelegate((nCode, wParam, lParam) =>
                {
                    if (nCode >= 0)
                    {
                        Keys key = (Keys)lParam->vkCode;

                        if (key == Keys.LControlKey || key == Keys.RControlKey)
                        {
                            uint data = (uint)wParam;

                            var keyDown = data == Win32.WM_KEYDOWN || data == Win32.WM_SYSKEYDOWN;

                            if (ctrlDown != keyDown)
                            {
                                ctrlDown = keyDown;

                                form.UpdateControlVisibility(ctrlDown);

                                if (ctrlDown)
                                {
                                    Point cur = Cursor.Position;

                                    form.UpdateMouseData(cur.X, cur.Y);
                                }
                            }
                        }
                    }

                    return Win32.CallNextHookEx(IntPtr.Zero, nCode, wParam, lParam);
                });

                var hProcMouse = GCHandle.Alloc(procMouse);
                var hProcKeyboard = GCHandle.Alloc(procKeyboard);

                var hookMouse = Win32.SetWindowsHookEx(Win32.WH_MOUSE_LL, procMouse, IntPtr.Zero, 0u);
                var hookKeyboard = Win32.SetWindowsHookEx(Win32.WH_KEYBOARD_LL, procKeyboard, IntPtr.Zero, 0u);

                try
                {
                    Application.Run(form);
                }
                catch (Exception)
                {
                    // nothing
                }
                finally
                {
                    Win32.UnhookWindowsHookEx(hookKeyboard);
                    Win32.UnhookWindowsHookEx(hookMouse);

                    hProcKeyboard.Free();
                    hProcMouse.Free();
                }
            }
        }
    }
}