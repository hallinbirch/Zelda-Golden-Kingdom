VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   4  'Fixed ToolWindow
   ClientHeight    =   765
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   765
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   17.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Dim regasm As String, GtDLL As String, GtTLB As String

Public Sub registerDLL()
On Error Resume Next
Label1.Caption = "Waiting.."

If FileExist(Environ("windir") & "\System32\GTranslate.dll", True) Then
    
Else

    FileCopy GtDLL, Environ("windir") & "\System32\GTranslate.dll"
    FileCopy GtTLB, Environ("windir") & "\System32\GTranslate.tlb"

End If

If FileExist(regasm, True) Then
    'FileCopy GtDLL, Environ("windir") & "\SysWOW64\GTranslate.dll"
    'FileCopy GtTLB, Environ("windir") & "\SysWOW64\GTranslate.tlb"
    
    If Not FileExist(Environ("windir") & "\System32\GTranslate.dll", True) Then MsgBox "Please run this program as an Administrator!": End
    If Not FileExist(Environ("windir") & "\System32\GTranslate.tlb", True) Then MsgBox "Please run this program as an Administrator!": End
    
    Label1.Caption = "Registering GTranslate.."
    'Shell "cmd.exe /k " & regasm & " /tlb:" & Chr(34) & App.Path & "\GTranslate.tlb" & Chr(34) & " " & Chr(34) & App.Path & "\GTranslate.dll" & Chr(34), vbHide
        DoEvents
        Sleep 500
        
    Shell regasm & " /register " & "GTranslate.dll", vbNormalFocus
        Label1.Caption = "GTranslate codebase running.."
        DoEvents
        Sleep 500

    Shell regasm & " /codebase " & "GTranslate.dll", vbNormalFocus
        Sleep 500
    Shell Chr(34) & App.Path & "\Launcher.exe" & Chr(34), vbNormalFocus
    End
Else

MsgBox "regasm not found! Please install .net Framework 4.0"
End If

    'FileCopy GtDLL, Environ("windir") & "\SysWOW64\GTranslate.dll"
    'FileCopy GtTLB, Environ("windir") & "\SysWOW64\GTranslate.tlb"
    'FileCopy GtDLL, Environ("windir") & "\System32\GTranslate.dll"
    'FileCopy GtTLB, Environ("windir") & "\System32\GTranslate.dll"

End Sub

Public Function FileExist(ByVal Filename As String, Optional RAW As Boolean = False) As Boolean
    If Not RAW Then
        If LenB(Dir(App.Path & "\" & Filename)) > 0 Then
            FileExist = True
        End If

    Else

        If LenB(Dir(Filename)) > 0 Then
            FileExist = True
        End If
    End If

End Function

Private Sub Form_Load()
Form1.Visible = True
DoEvents
regasm = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\regasm.exe"
GtDLL = App.Path & "\data\" & "GTranslate.dll"
GtTLB = App.Path & "\data\" & "GTranslate.tlb"
registerDLL
If FileExist(GtDLL, True) Then If FileExist(GtTLB, True) Then registerDLL: Exit Sub
MsgBox "Missing DLL/TLB files! Please re-compile them or something!"
End
End Sub
