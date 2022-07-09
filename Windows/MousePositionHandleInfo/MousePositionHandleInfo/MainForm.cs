// Copyright (C) Martin Wetzko
// See the LICENSE file in the project root for more information

using System;
using System.Diagnostics;
using System.Windows.Forms;

namespace MousePositionHandleInfo
{
    public unsafe partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();

            lblMousePositionValue.Text = string.Empty;
        }

        protected override void OnShown(EventArgs e)
        {
            base.OnShown(e);

            this.ActiveControl = lblMousePosition;
        }

        public void UpdateMouseData(int x, int y)
        {
            lblMousePositionValue.Text = $"X={x} Y={y}";

            var hwnd = Win32.WindowFromPoint(new POINT { x = x, y = y });

            if (hwnd == IntPtr.Zero)
            {
                txtHandleTextValue.Text = string.Empty;
                txtHandleValue.Text = string.Empty;
                txtParentHandleValue.Text = string.Empty;
                txtOwnerHandleValue.Text = string.Empty;
                txtProcessInfoValue.Text = string.Empty;
            }
            else
            {
                txtHandleTextValue.Text = Win32.GetWindowText(hwnd);
                txtHandleValue.Text = $"0x{hwnd:X8}"; ;
                txtParentHandleValue.Text = $"0x{Win32.GetParentHandle(hwnd):X8}";
                txtOwnerHandleValue.Text = $"0x{Win32.GetWindow(hwnd, Win32.GW_OWNER):X8}";

                Win32.GetWindowThreadProcessId(hwnd, out uint processId);

                try
                {
                    using (Process process = Process.GetProcessById((int)processId))
                    {
                        txtProcessInfoValue.Text = $"{process.ProcessName} ({process.Id})";
                    }
                }
                catch (Exception ex)
                {
                    txtProcessInfoValue.Text = ex.Message;
                }
            }
        }

        public void UpdateControlVisibility(bool show)
        {
            lblCtrl.Visible = show;
        }

        void cbTopmost_CheckedChanged(object sender, EventArgs e)
        {
            this.TopMost = cbTopmost.Checked;
        }
    }
}