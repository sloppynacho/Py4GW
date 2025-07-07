#AutoIt3Wrapper_UseX64=n

#include "GWA2_new.au3"
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>


Global $Paused
HotKeySet("+s", "TogglePause") 	;Shift + s
HotKeySet("+t", "Terminate")	;Shift + t

Opt("TrayAutoPause", 0)
TraySetToolTip("GW Chat Spam" & " - " )

Initialize2()

While 1
Local $aMessage = 'WTS Ecto 3.25€(250) Paypal --- I will only do small Transactions | PM' ;Message here
Local $aChannel = '$'		;Channel here
  SendChat($aMessage, $aChannel)
			Sleep(10000)	;10 seconds
		RndSleep(20000)		;15 seconds
WEnd

Func TogglePause()
    $Paused = Not $Paused
    While $Paused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip('Script is "Running"', 0, 0)
EndFunc   ;==>TogglePause

Func Terminate()
    Exit 0
EndFunc   ;==>Terminate