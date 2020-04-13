#NoTrayIcon
#Persistent

SetBatchLines, -1
Process, Priority,, High

Gui +LastFound
hWnd := WinExist()

DllCall( "RegisterShellHookWindow", UInt, hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str, "SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )

Return

ShellMessage( wParam, lParam )
{
    If ( wParam = 1 ) ;  HSHELL_WINDOWCREATED := 1
    {
        WinGet, win, ProcessName, ahk_id %lParam%
        WinGetClass, class, ahk_id %lParam%
        WinGetTitle, title, ahk_id %lParam%

        If ( win = "Explorer.EXE" and class = "CabinetWClass" )
        {
            WinGetPos, xPos, yPos, width, height, %title%
            WinMove, %title%, , %xPos%, %yPos%, 1280, 720
        }
    }
}
