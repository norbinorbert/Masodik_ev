namespace Deliveries
{
    partial class ErrorForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.rtbError = new System.Windows.Forms.RichTextBox();
            this.SuspendLayout();
            // 
            // rtbError
            // 
            this.rtbError.Dock = System.Windows.Forms.DockStyle.Fill;
            this.rtbError.Enabled = false;
            this.rtbError.Location = new System.Drawing.Point(0, 0);
            this.rtbError.Name = "rtbError";
            this.rtbError.Size = new System.Drawing.Size(610, 240);
            this.rtbError.TabIndex = 0;
            this.rtbError.Text = "";
            // 
            // ErrorForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(610, 240);
            this.Controls.Add(this.rtbError);
            this.Name = "ErrorForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "ErrorForm";
            this.Load += new System.EventHandler(this.ErrorForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.RichTextBox rtbError;



    }
}