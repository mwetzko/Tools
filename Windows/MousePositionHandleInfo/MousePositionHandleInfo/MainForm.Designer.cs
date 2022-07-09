namespace MousePositionHandleInfo
{
    partial class MainForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblMousePosition = new System.Windows.Forms.Label();
            this.lblHandle = new System.Windows.Forms.Label();
            this.lblMousePositionValue = new System.Windows.Forms.Label();
            this.txtHandleValue = new System.Windows.Forms.TextBox();
            this.lblParentHandle = new System.Windows.Forms.Label();
            this.txtParentHandleValue = new System.Windows.Forms.TextBox();
            this.lblOwnerHandle = new System.Windows.Forms.Label();
            this.txtOwnerHandleValue = new System.Windows.Forms.TextBox();
            this.lblHandleText = new System.Windows.Forms.Label();
            this.txtHandleTextValue = new System.Windows.Forms.TextBox();
            this.lblProcessInfo = new System.Windows.Forms.Label();
            this.txtProcessInfoValue = new System.Windows.Forms.TextBox();
            this.lblCtrl = new System.Windows.Forms.Label();
            this.cbTopmost = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // lblMousePosition
            // 
            this.lblMousePosition.AutoSize = true;
            this.lblMousePosition.Location = new System.Drawing.Point(10, 10);
            this.lblMousePosition.Name = "lblMousePosition";
            this.lblMousePosition.Size = new System.Drawing.Size(92, 15);
            this.lblMousePosition.TabIndex = 0;
            this.lblMousePosition.Text = "Mouse Position:";
            // 
            // lblHandle
            // 
            this.lblHandle.AutoSize = true;
            this.lblHandle.Location = new System.Drawing.Point(10, 70);
            this.lblHandle.Name = "lblHandle";
            this.lblHandle.Size = new System.Drawing.Size(48, 15);
            this.lblHandle.TabIndex = 4;
            this.lblHandle.Text = "Handle:";
            // 
            // lblMousePositionValue
            // 
            this.lblMousePositionValue.AutoSize = true;
            this.lblMousePositionValue.Location = new System.Drawing.Point(110, 10);
            this.lblMousePositionValue.Name = "lblMousePositionValue";
            this.lblMousePositionValue.Size = new System.Drawing.Size(43, 15);
            this.lblMousePositionValue.TabIndex = 1;
            this.lblMousePositionValue.Text = "[Value]";
            // 
            // txtHandleValue
            // 
            this.txtHandleValue.Location = new System.Drawing.Point(110, 67);
            this.txtHandleValue.Name = "txtHandleValue";
            this.txtHandleValue.ReadOnly = true;
            this.txtHandleValue.Size = new System.Drawing.Size(262, 23);
            this.txtHandleValue.TabIndex = 5;
            // 
            // lblParentHandle
            // 
            this.lblParentHandle.AutoSize = true;
            this.lblParentHandle.Location = new System.Drawing.Point(10, 100);
            this.lblParentHandle.Name = "lblParentHandle";
            this.lblParentHandle.Size = new System.Drawing.Size(85, 15);
            this.lblParentHandle.TabIndex = 6;
            this.lblParentHandle.Text = "Parent Handle:";
            // 
            // txtParentHandleValue
            // 
            this.txtParentHandleValue.Location = new System.Drawing.Point(110, 97);
            this.txtParentHandleValue.Name = "txtParentHandleValue";
            this.txtParentHandleValue.ReadOnly = true;
            this.txtParentHandleValue.Size = new System.Drawing.Size(262, 23);
            this.txtParentHandleValue.TabIndex = 7;
            // 
            // lblOwnerHandle
            // 
            this.lblOwnerHandle.AutoSize = true;
            this.lblOwnerHandle.Location = new System.Drawing.Point(10, 130);
            this.lblOwnerHandle.Name = "lblOwnerHandle";
            this.lblOwnerHandle.Size = new System.Drawing.Size(86, 15);
            this.lblOwnerHandle.TabIndex = 8;
            this.lblOwnerHandle.Text = "Owner Handle:";
            // 
            // txtOwnerHandleValue
            // 
            this.txtOwnerHandleValue.Location = new System.Drawing.Point(110, 127);
            this.txtOwnerHandleValue.Name = "txtOwnerHandleValue";
            this.txtOwnerHandleValue.ReadOnly = true;
            this.txtOwnerHandleValue.Size = new System.Drawing.Size(262, 23);
            this.txtOwnerHandleValue.TabIndex = 9;
            // 
            // lblHandleText
            // 
            this.lblHandleText.AutoSize = true;
            this.lblHandleText.Location = new System.Drawing.Point(10, 40);
            this.lblHandleText.Name = "lblHandleText";
            this.lblHandleText.Size = new System.Drawing.Size(52, 15);
            this.lblHandleText.TabIndex = 2;
            this.lblHandleText.Text = "Caption:";
            // 
            // txtHandleTextValue
            // 
            this.txtHandleTextValue.Location = new System.Drawing.Point(110, 37);
            this.txtHandleTextValue.Name = "txtHandleTextValue";
            this.txtHandleTextValue.ReadOnly = true;
            this.txtHandleTextValue.Size = new System.Drawing.Size(262, 23);
            this.txtHandleTextValue.TabIndex = 3;
            // 
            // lblProcessInfo
            // 
            this.lblProcessInfo.AutoSize = true;
            this.lblProcessInfo.Location = new System.Drawing.Point(10, 160);
            this.lblProcessInfo.Name = "lblProcessInfo";
            this.lblProcessInfo.Size = new System.Drawing.Size(74, 15);
            this.lblProcessInfo.TabIndex = 10;
            this.lblProcessInfo.Text = "Process Info:";
            // 
            // txtProcessInfoValue
            // 
            this.txtProcessInfoValue.Location = new System.Drawing.Point(110, 157);
            this.txtProcessInfoValue.Name = "txtProcessInfoValue";
            this.txtProcessInfoValue.ReadOnly = true;
            this.txtProcessInfoValue.Size = new System.Drawing.Size(262, 23);
            this.txtProcessInfoValue.TabIndex = 11;
            // 
            // lblCtrl
            // 
            this.lblCtrl.AutoSize = true;
            this.lblCtrl.Location = new System.Drawing.Point(334, 10);
            this.lblCtrl.Name = "lblCtrl";
            this.lblCtrl.Size = new System.Drawing.Size(34, 15);
            this.lblCtrl.TabIndex = 12;
            this.lblCtrl.Text = "CTRL";
            this.lblCtrl.Visible = false;
            // 
            // cbTopmost
            // 
            this.cbTopmost.AutoSize = true;
            this.cbTopmost.Location = new System.Drawing.Point(245, 9);
            this.cbTopmost.Name = "cbTopmost";
            this.cbTopmost.Size = new System.Drawing.Size(72, 19);
            this.cbTopmost.TabIndex = 13;
            this.cbTopmost.Text = "Topmost";
            this.cbTopmost.UseVisualStyleBackColor = true;
            this.cbTopmost.CheckedChanged += new System.EventHandler(this.cbTopmost_CheckedChanged);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(384, 191);
            this.Controls.Add(this.cbTopmost);
            this.Controls.Add(this.lblCtrl);
            this.Controls.Add(this.txtProcessInfoValue);
            this.Controls.Add(this.lblProcessInfo);
            this.Controls.Add(this.txtHandleTextValue);
            this.Controls.Add(this.lblHandleText);
            this.Controls.Add(this.txtOwnerHandleValue);
            this.Controls.Add(this.lblOwnerHandle);
            this.Controls.Add(this.txtParentHandleValue);
            this.Controls.Add(this.lblParentHandle);
            this.Controls.Add(this.txtHandleValue);
            this.Controls.Add(this.lblMousePositionValue);
            this.Controls.Add(this.lblHandle);
            this.Controls.Add(this.lblMousePosition);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Mouse Position Handle Info";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblMousePosition;
        private System.Windows.Forms.Label lblHandle;
        private System.Windows.Forms.Label lblMousePositionValue;
        private System.Windows.Forms.TextBox txtHandleValue;
        private System.Windows.Forms.Label lblParentHandle;
        private System.Windows.Forms.TextBox txtParentHandleValue;
        private System.Windows.Forms.Label lblOwnerHandle;
        private System.Windows.Forms.TextBox txtOwnerHandleValue;
        private System.Windows.Forms.Label lblHandleText;
        private System.Windows.Forms.TextBox txtHandleTextValue;
        private System.Windows.Forms.Label lblProcessInfo;
        private System.Windows.Forms.TextBox txtProcessInfoValue;
        private System.Windows.Forms.Label lblCtrl;
        private System.Windows.Forms.CheckBox cbTopmost;
    }
}