VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "Richtx32.ocx"
Begin VB.Form frmTransLog 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Translation"
   ClientHeight    =   3015
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   8085
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   8085
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrLog 
      Interval        =   60000
      Left            =   240
      Top             =   480
   End
   Begin RichTextLib.RichTextBox txtLog 
      Height          =   3015
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8055
      _ExtentX        =   14208
      _ExtentY        =   5318
      _Version        =   393217
      ScrollBars      =   2
      Appearance      =   0
      TextRTF         =   $"frmTransLog.frx":0000
   End
End
Attribute VB_Name = "frmTransLog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Resize()
txtLog.Width = Me.Width - 190
txtLog.height = Me.height - 550
End Sub

Private Sub tmrLog_Timer()
If Len(txtLog.Text) >= 600000 Then txtLog.Text = vbNullString
End Sub

Private Sub txtLog_Change()
With txtLog
    .SelStart = 2000000000
End With
End Sub
