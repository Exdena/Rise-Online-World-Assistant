/*
--------------------------------
# RiseOnlineWorld Assistant

This is a asistant tool that I used personally for Rise Online World. 
I am no longer playing, so no longer development.
It is a modified version of AHK_RiseOnlineWorld by pirik3
https://github.com/pirik3/AHK_RiseOnlineWorld

Kişisel olarak kullandığım Rise Online World için bir asistan aracıdır.
Oyunu artık oynamadığım geliştirme süreci de bitmiştir.
kran klavyesidir. Oyun engellediği için bir çok özellik eksiktir.
AHK_RiseOnlineWorld by pirik3 codunun değiştirilmiş halidir.
https://github.com/pirik3/AHK_RiseOnlineWorld

Discord: Exden#9510
--------------------------------
*/

if !A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#NoEnv
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On
SendMode, Input 
SetWorkingDir %A_ScriptDir%
CoordMode Pixel, Window
SetKeyDelay, 150

;============================== GUI 
global StatusDebuff := 0 ; Off
global StatusHPPot := 0 ; Off
global StatusMPPot := 0 ; Off
global StatusSTR30 := 0 ; Off
global StatusAP50 := 0 ; Off
global StatusAttack = 0 ; Off
global StatusLoot := 0 ; Off

icon_png := Create_icon_png() ; HBITMAP:*%icon_png%
Menu Tray, Icon, HBITMAP:*%icon_png%
Menu, Tray, Tip , Control GUI

bar_png := Create_bar_png() ; HBITMAP:*%titlebar_png%
bg_png := Create_bg_png() ; HBITMAP:*%bg_png%
closebutton_png := Create_closebutton_png() ; HBITMAP:*%closebutton_png%
buttonon_png := Create_buttonon_png() ; HBITMAP:*%buttonon_png%
buttonoff_png := Create_buttonoff_png() ; HBITMAP:*%buttonoff_png%
ap50_bmp := Create_ap50_bmp() ; HBITMAP:*%ap50_bmp%
attack_bmp := Create_attack_bmp() ; HBITMAP:*%attack_bmp%
hp_bmp := Create_hp_bmp() ; HBITMAP:*%hp_bmp%
loot_bmp := Create_loot_bmp() ; HBITMAP:*%loot_bmp%
mp_bmp := Create_mp_bmp() ; HBITMAP:*%mp_bmp%
otoattack_bmp := Create_otoattack_bmp() ; HBITMAP:*%otoattack_bmp%
str30_bmp := Create_str30_bmp() ; HBITMAP:*%str30_bmp%

Gui, +AlwaysOnTop +Border -Caption +Owner

Gui, Add, Picture, x0 y0 gUImove, HBITMAP:*%bar_png%
Gui, Add, Picture, x0 y40, HBITMAP:*%bg_png%
Gui, Add, Picture, x458 y43 +BackgroundTrans gCloseControlGUI, HBITMAP:*%closebutton_png%

Gui, Add, Picture, x275 y172 +BackgroundTrans, HBITMAP:*%ap50_bmp%
Gui, Add, Picture, x25 y172 +BackgroundTrans, HBITMAP:*%str30_bmp%
Gui, Add, Picture, x25 y97 +BackgroundTrans, HBITMAP:*%hp_bmp%
Gui, Add, Picture, x275 y97 +BackgroundTrans, HBITMAP:*%mp_bmp%
Gui, Add, Picture, x25 y247 +BackgroundTrans, HBITMAP:*%otoattack_bmp%
Gui, Add, Picture, x275 y247 +BackgroundTrans, HBITMAP:*%loot_bmp%
Gui, Add, Picture, x40 y51 +BackgroundTrans, HBITMAP:*%attack_bmp%

Gui, font, cWhite
Gui, font, s16, Times New Roman

Gui, Add, Text, x80 y54 +BackgroundTrans, Single Attack
Gui, Add, Text, x200 y54 +BackgroundTrans, [Num0] Debuff:
Gui, Add, Picture, x340 y47 +BackgroundTrans vSwitchDebuff0 gClickDebuff hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x340 y47 +BackgroundTrans vSwitchDebuff1 gClickDebuff, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x10 y130 +BackgroundTrans, HP Pot
Gui, Add, Text, x87 y130 +BackgroundTrans, [Num1]
Gui, Add, Text, x187 y150 +BackgroundTrans vTextHPPot, Off
Gui, Add, Picture, x160 y112 +BackgroundTrans vSwitchHPPot0 gClickHPPot hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x160 y112 +BackgroundTrans vSwitchHPPot1 gClickHPPot, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x260 y130 +BackgroundTrans, MP Pot
Gui, Add, Text, x337 y130 +BackgroundTrans, [Num2]
Gui, Add, Text, x437 y150 +BackgroundTrans vTextMPPot, Off
Gui, Add, Picture, x410 y112 +BackgroundTrans vSwitchMPPot0 gClickMPPot hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x410 y112 +BackgroundTrans vSwitchMPPot1 gClickMPPot, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x10 y205 +BackgroundTrans, STR30
Gui, Add, Text, x87 y205 +BackgroundTrans, [Num3]
Gui, Add, Text, x187 y225 +BackgroundTrans vTextSTR30, Off
Gui, Add, Picture, x160 y187 +BackgroundTrans vSwitchSTR300 gClickSTR30 hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x160 y187 +BackgroundTrans vSwitchSTR301 gClickSTR30, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x260 y205 +BackgroundTrans, AP `%50
Gui, Add, Text, x337 y205 +BackgroundTrans, [Num4]
Gui, Add, Text, x437 y225 +BackgroundTrans vTextAP50, Off
Gui, Add, Picture, x410 y187 +BackgroundTrans vSwitchAP500 gClickAP50 hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x410 y187 +BackgroundTrans vSwitchAP501 gClickAP50, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x10 y280 +BackgroundTrans, Attack
Gui, Add, Text, x87 y280 +BackgroundTrans, [Num5]
Gui, Add, Text, x187 y300 +BackgroundTrans vTextAttack, Off
Gui, Add, Picture, x160 y262 +BackgroundTrans vSwitchAttack0 gClickAttack hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x160 y262 +BackgroundTrans vSwitchAttack1 gClickAttack, HBITMAP:*%buttonoff_png%

Gui, Add, Text, x260 y280 +BackgroundTrans, OtoLoot
Gui, Add, Text, x337 y280 +BackgroundTrans, [Num6]
Gui, Add, Text, x437 y300 +BackgroundTrans vTextLoot, Off
Gui, Add, Picture, x410 y262 +BackgroundTrans vSwitchLoot0 gClickLoot hidden, HBITMAP:*%buttonon_png%
Gui, Add, Picture, x410 y262 +BackgroundTrans vSwitchLoot1 gClickLoot, HBITMAP:*%buttonoff_png%

CloseControlGUI()
{
	Exitapp
}

UImove()
{
	PostMessage, 0xA1, 2,,, A
}

ClickDebuff()
{
	GuiControl Hide, SwitchDebuff%StatusDebuff%
	GuiControl, +Redraw, SwitchDebuff%StatusDebuff%
	StatusDebuff := 1 - StatusDebuff
	GuiControl Show, SwitchDebuff%StatusDebuff%
	GuiControl, -Redraw, SwitchDebuff%StatusDebuff%
}

ClickHPPot()
{
	GuiControl Hide, SwitchHPPot%StatusHPPot%
	GuiControl, +Redraw, SwitchHPPot%StatusHPPot%
	StatusHPPot := 1 - StatusHPPot
	GuiControl Show, SwitchHPPot%StatusHPPot%
	GuiControl, -Redraw, SwitchHPPot%StatusHPPot%
	
	if (StatusHPPot=0)
	{
		GuiControl,, TextHPPot, Off
	}
	else
	{
		GuiControl,, TextHPPot, On
	}
}

ClickMPPot()
{
	GuiControl Hide, SwitchMPPot%StatusMPPot%
	GuiControl, +Redraw, SwitchMPPot%StatusMPPot%
	StatusMPPot := 1 - StatusMPPot
	GuiControl Show, SwitchMPPot%StatusMPPot%
	GuiControl, -Redraw, SwitchMPPot%StatusMPPot%
	
	if (StatusMPPot=0)
	{
		GuiControl,, TextMPPot, Off
	}
	else
	{
		GuiControl,, TextMPPot, On
	}
}

ClickSTR30()
{
    GuiControl Hide, SwitchSTR30%StatusSTR30%
	GuiControl, +Redraw, SwitchSTR30%StatusSTR30%
    StatusSTR30 := 1 - StatusSTR30
    GuiControl Show, SwitchSTR30%StatusSTR30%
	GuiControl, -Redraw, SwitchSTR30%StatusSTR30%
	
	if (StatusSTR30=0)
	{
		GuiControl,, TextSTR30, Off
	}
	else
	{
		GuiControl,, TextSTR30, On
	}
}

ClickAP50()
{
    GuiControl Hide, SwitchAP50%StatusAP50%
	GuiControl, +Redraw, SwitchAP50%StatusAP50%
    StatusAP50 := 1 - StatusAP50
    GuiControl Show, SwitchAP50%StatusAP50%
	GuiControl, -Redraw, SwitchAP50%StatusAP50%
	
	if (StatusAP50=0)
	{
		GuiControl,, TextAP50, Off
	}
	else
	{
		GuiControl,, TextAP50, On
	}
}

ClickAttack()
{
	GuiControl Hide, SwitchAttack%StatusAttack%
	GuiControl, +Redraw, SwitchAttack%StatusAttack%
	StatusAttack := 1 - StatusAttack
	GuiControl Show, SwitchAttack%StatusAttack%
	GuiControl, -Redraw, SwitchAttack%StatusAttack%
	if (StatusAttack=0)
	{
		GuiControl,, TextAttack, Off
	}
	else
	{
		GuiControl,, TextAttack, On
	}
}

ClickLoot()
{
	GuiControl Hide, SwitchLoot%StatusLoot%
	GuiControl, +Redraw, SwitchLoot%StatusLoot%
	StatusLoot := 1 - StatusLoot
	GuiControl Show, SwitchLoot%StatusLoot%
	GuiControl, -Redraw, SwitchLoot%StatusLoot%
	
	if (StatusLoot=0)
	{
		GuiControl,, TextLoot, Off
	}
	else
	{
		GuiControl,, TextLoot, On
	}
}

;============================== Pixel Read

WinActivate, Rise Online Client
WinWaitActive, Rise Online Client,, 2
Sleep, 200
WinGetPos, X, Y, W, H, Rise Online Client
IfWinActive, Rise Online Client
{
	PixelGetColor, hp_passive, 260, 100 ; 0x9B231E
	PixelGetColor, mp_passive, 160, 120 ; 0x1B4478
}
else
{
	MsgBox, 262192, Uyari!, Rise Online pencerisi one getirilemedi`, script kapatilacak.
	Exitapp
}

WinGetPos,,,,TrayHeight,ahk_class Shell_TrayWnd,,,
height := H-350-TrayHeight
width := W-510-TrayHeight
Gui, Show, w500 h340 x%width% y%height%, Control GUI

global hp_passive
global mp_passive
global str30:="|<str30>*42$40.zzs0yzzzzk3tzzzzUDXzzsz0z7zzVk7wDzw41zUzzU1zy1zy0Tzs7zk3zzUTz0TzzUzw3szzVzkD7zz7z0szzzzs7XzzzzUzzzzzz7zzzzzwTzzzzznzzzzzzDzzzzzyTzzzzztzyTzzznzUzzzzDk3zzzy807zzzw00Dzy"
global book:="|<book>*74$42.zzzzznzzzzTzzDzzyzyzzzzxzxzzzzvzmTzzzvzUTXzzrzYk3zzzz003zzTz007zyzzE07zwzy00Dzxzy00Dztw100Tzk0000TzU0000zz00Y00zz00001zy00301zw00UU3zs00003zk00007zk0200Dzk0100Dzzk000Tzzz000TzU"
global drop4:="|<drop4>*60$30.zzzzzy6ryztqryzvyzyznyr6rnyqybnyoyDvyoyjsyqSry6r2nzzzzzU"
global debuff1:="|<debuff1>*49$40.zzA03zzzsk0DzzzU20xzzy0y3rzzs7kCTzz0yEwzzw3z3HzzsDs9Dzz0zUUnzw1z00Tzk7w0Dzz0DU3zw00z7zzz0zzzzzzzzzzjzzzzzVzzzzzwDzk3zz0Tzs7zs1zzoDzU7zykzy0Tzr3zk3zzQ7z0DzzkTw1zzz1zkDy"


;============================== Loop Cycle

Loop
{
	CoordMode Pixel, Window
	Process, Exist, RiseOnline-Win64-Shipping.exe
	if errorlevel
	{
		if (StatusHPPot = 1)
		{
			DrinkHPPot()
		}
		if (StatusMPPot = 1)
		{
			DrinkMPPot()
		}
		if (StatusSTR30 = 1)
		{
			PriSTR30()
		}
		if (StatusAP50 = 1)
		{
			PriBook()
		}
		if (StatusAttack = 1)
		{
			Attack()
		}
		if (StatusLoot = 1)
		{
			AutoLoot()
		}
		Sleep, 500
	}

	Else
	{
		MsgBox, 262192, Uyari!, Rise Online acik degil`, script kapatilacak.
        Exitapp
	}
}

;============================== Auto Loot

AutoLoot()
{
	ControlSend,,{F Down}{F Up},AHK_exe RiseOnline-Win64-Shipping.exe
	MouseGetPos, xpos, ypos 
	if (ok:=FindText(X, Y, xpos, ypos, xpos+300, ypos+200, 0, 0, drop4))
	{
		slot1x := X-5
		slot1y := Y+55
		slot2x := X+45
		slot2y := Y+55
		slot3x := X+90
		slot3y := Y+55
		ControlClick, x%slot1x% y%slot1y%, AHK_exe RiseOnline-Win64-Shipping.exe, , Right
		ControlClick, x%slot2x% y%slot2y%, AHK_exe RiseOnline-Win64-Shipping.exe, , Right
		ControlClick, x%slot3x% y%slot3y%, AHK_exe RiseOnline-Win64-Shipping.exe, , Right
	}
}

;============================== Drink Potion

DrinkHPPot()
{
	;HP Pot
	IfWinActive, Rise Online Client
	{
		if (ok:=FindText("wait0",0, 1300, 570, 1750, 655, 0, 0, debuff1))  
		{
			PixelGetColor, hp_active, 260, 100 ; 0x9B231E
			if (hp_active != hp_passive) && (hp_active != 0x6C024D)  
			{
				ControlSend,,{6 Down}{6 Up},AHK_exe RiseOnline-Win64-Shipping.exe
			}
		}
	}
}
DrinkMPPot()
{
	;MANA Pot
	IfWinActive, Rise Online Client
	{
		PixelGetColor, mp_active, 160, 120 ; 0x1B4478
		if (mp_active != mp_passive)
		{
			ControlSend,,{7 Down}{7 Up},AHK_exe RiseOnline-Win64-Shipping.exe
		}
	}
}

;============================== Priest Buffs

PriBook()
{
	if (ok:=FindText("wait0",0, 1300, 570, 1750, 655, 0, 0, book))  
	{
		ControlSend,,{9 Down}{9 Up},AHK_exe RiseOnline-Win64-Shipping.exe
	}
}

PriSTR30()
{
	if (ok:=FindText("wait0",0, 1300, 570, 1750, 655, 0, 0, str30))  
	{
		ControlSend,,{8 Down}{8 Up},AHK_exe RiseOnline-Win64-Shipping.exe
	}
}

;============================== Single Attack

Attack()
{
		ControlSend,,{z Down}{z Up},AHK_exe RiseOnline-Win64-Shipping.exe
		If (StatusDebuff = 1)
		{
			ControlSend,,{3 Down}{3 Up},AHK_exe RiseOnline-Win64-Shipping.exe
			Sleep, 2000
		}
		ControlSend,,{r Down}{r Up},AHK_exe RiseOnline-Win64-Shipping.exe
}

;============================== Hotkeys

$Numpad0::Attack()
$Numpad1::ClickHPPot()
$Numpad2::ClickMPPot()
$Numpad3::ClickSTR30()
$Numpad4::ClickAP50()
$Numpad5::ClickAttack()
$Numpad6::ClickLoot()
return


;============================== HBITMAPS
; ## This #Include file was generated by Image2Include.ahk ##
; Bitmap creation adopted from "How to convert Image data (JPEG/PNG/GIF) to hBITMAP?" by SKAN
; -> http://www.autohotkey.com/board/topic/21213-how-to-convert-image-data-jpegpnggif-to-hbitmap/?p=139257

Create_icon_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 940 << !!A_IsUnicode)
B64 := "iVBORw0KGgoAAAANSUhEUgAAACYAAAAmCAYAAACoPemuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmBQkLFzHhKfmIAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTA1LTA5VDExOjIzOjQ5KzAwOjAwIy1dDgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0wNS0wOVQxMToyMzo0OSswMDowMFJw5bIAAAG0SURBVFhHtZdLTsRQDATDXIEtS+5/Ipaz5QyAo3HkOO52OwklRYrwr55fhOBtWZafv0fm++Pz9Tbn/fn1euuRxa4IZRTBVqwTYkOu1FIx1HhyJc60FxSrGp0Ryqh9S7FczITQJoxJXc49iClSTAah9Ik5O7H/korknmjmJtZJIaFK3lFrqtmP1/sORcpymJSBcrolGKsYOpmBpCZUgt3M9SpjEmuAhCbyOTfmxdijauqwmGFxlINiSNiIsd03huyN3BAJZbo8FC8//kwnZfH8RLpDVkhiEXVIJ4fwuk0sNopN2OlYzFBrK+nRxpiwxfyJdAKI8VVW5IETAcQtYk53tRNuFbtjU84tYnlTd2xuJMY+ZIv5E4l5E+FNDDVg19NdnVpbCY+vkm0kkn+ubsvrJLFuiMXzw+jiBhTrTqhuwPJYLoo9YoCdpIqxoSimzjj8oWgwWSSiMJmzXiUblmPWIDfpqGq6meU3pjRRBFFOddjM6P/KTkSh6+nxnZjRyRlnBJU+MecgZihyDpOc1OXcUsyoBrJBKmrf0S9Yth2FyWHhxhwmo2zwbH0r5lzdVqQ/0LL8AqTlSu5c0AtRAAAAAElFTkSuQmCC"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_bar_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 620 << !!A_IsUnicode)
B64 := "iVBORw0KGgoAAAANSUhEUgAAAfQAAAAoCAYAAAAIXQhqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmBQkLFzJ4IKgyAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTA1LTA5VDExOjIzOjUwKzAwOjAweh8YQwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0wNS0wOVQxMToyMzo1MCswMDowMAtCoP8AAADCSURBVHhe7dXBDcAwDAMxp/vv3ObRJXwgAUEj3JmZ9w4AWOz5HwBYTNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQASBA0AEgQNABIEDQAWC9mQ+TawFPBhkYmQAAAABJRU5ErkJggg=="
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_bg_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 114780 << !!A_IsUnicode)
B64 := "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"
B64 .= "60viBeY4rG+m02rik/VGrH87Q6KRYv8TrSna+qLR7kXwqV+uD3dtKONdgrAx/l1Nzu/17nQrWeczI1flXO8/29GGe0Lb/P3Z+3Tjg6eLRDhQTuGByoJdw8D1+neemzqz5ezzNzqPp24IJQZbpW1TCaT7KHh8dT3EnEwPsv6qtDVqyTkG3dfTd6B6rdbRs5EXr7fXmONZFpRes+9Ema2aZ4VnjwDXEF2RPJ8MBJWu68mZhqRpO1EYyf2B6Ag3ZQ/gpFLHt3JpmdevAC6IIo8JY5Yy1cAlx7a0ZV68inoP4HgmKY3RpS8zoBbtX1tzX0VnekOdcva31qKJqS0ph0ZOCp4x3h7To2snFpFp5zOpSwCiWWorgY+vu9U93unFWt50Sc1qgHpmHn96m/X3fNuVN+atgAlwkeaIYwsa+jspxzeism0tjFLKmzhypFRxxZ7F0WJqC8n5lFD4vhDnv/GJQ0y6Mbc4XtXtQA67NFcvYib42XoION/ltx9GsCqVu5hGn9sP8kMNrWVpxEbOu4aN8kVMHlOgjiEll99sNb7+gql1Kb5UmVNTLIdZX0ratSuWZniJ7PkUD5SlfT6TLTrsvOdTnxxZ5/axk85brg0vaL2V0MpFSyHJksirFlePGOOWQWyCU3sjiiq6hdEu5hYlils9hFPD6jPz/EYJZV1VVcgLb5ojn9DEfEOEXyfPFrQ5TGdja1a1EZc+nlPObE9TlpjaUrRpaVb6szwoTxtBYl5D0qCUtowkgmM87Jc6gEOmSwV9PfdRvkedkI9ltqyya23u6M2Nk2yGe4WOoAWzsgOowl/00ptR6s8+x8N6Zlo39mP07fRSeeN4gUbtEd0f+x9gUlXQeHdwjuZ2fNGanLRX57tsXG+h38KlFXS+GwM2/fXrj3XtfjYZhR6cu1r/AwLAltRyhTerQWnRXi7jzWvrqMSlFKoahsr0gkb40d+DIQ2IQ5BkZfvgh0IhOHolJwyJxigchWy9ZRR+S2epTGS0OFpudZx6qFB0oXctRXPeceVtWxh91NnskmE1m5BjjgdcdlLgxHg0wX76i8/efkoBpHXDMKCuZ1pwJOi1yzyWT8nc44YFvAQPkvBmCO4P6nP8gpdE+PUCE0eOBVacsTkO7e3FUYRKTOv9ndZlCpYd9+ct9GSPaA5arT5qnqdYdtH+6KriYecW7RaBZVb3UV91zo9kqcry09gGaxw9fyVyGnipNhrmUs/utZerNP2n7KuuHdmRNtj1zPOXynPk3hQt0lOYPY/fUfIot/vni3Ok/CS/B93RHp/Lp6zvFTG7eaJoBlN7PY+MJatU6Mdn8jd0ujf5vNRUS3TUBwCbNjuehB1vtlQOX8USwCi/w2zdltEU23qi5aCbk3fZRSwnjdtqMVROGe/00VKxnhhw456N7FZh9HmOjV6qUPXibW1Bq1EzTgU/a3mW05sUjeVylMLuBpSpmFy/0SV57gLxEy/2kAA4St+VWn1oGhVv3iRhvI8WNhTzpsXavmc6k5/GliFz22LV8ADx1t57TjMgiSxFEtDqK9oLyWHd3RsS0IQZPgoftt7h16IugQ7FUt+fRk+/yyvbs3XB0/tJZtdxK6jljjwJ30rtta3/edzF5vco7cVP3oFTo5q1do/B2eeDz3hn9bLedG1xiCAr//nJ365TAgYy53s90WjofD+bckxVE8xxn2KHv86N7XarBs35FNRaFbHSpPC860jrWY0nhljvTetLoMRkZ7UkKoXdV2tv9Pr2B6aGTn5YSuHBSXM2lusZmwRSx75qcW4Szs/rWxiTmbH47m33faQJQB71XbEPKjn+XILNHBmwPp75+MlWZmG4WgacDonOPFV9kVvhY7cjrHPZuSoLWq9K3ogClUCWYGIH5Ep6rI573EiQL5IuQF+DUFcjfMc9DSAtI37G8N48Ymj0aOs9BR1a64zEcWbVtJZpp96SnwwbXGNaffCuuPap+Kc9OuJ6ZNtR/ZmHVIlPpHpGxHMlNTxzcntjfgUwqcmvU5f/3ENcbeFuP4/0fNtbZajn8e8/+9RE5ZJ+xf5oxdX699RmarNB9rCjfBPgK7N7pNrst+9EOx+gDpvizNH1Uuu1e+2PHBKapVbbSTWeThUZKN7vsVF1bOZq3m60bYnA320ZOnx6+zWo+tvaAxvWuiZ3uzXVTg9DPCqM0dZB4rSx7vaW6hfVJsQszYcTqUxDjIwR6YSNIyV7iRJ+bVBSaptsrHGqLa0eXZzNoYFQtYSjcERkjlm/NhtbIQ3GlCrx2WlYZQUdL5NzSap3e93e3fvvVSPQUQ3ld97mMYb7Ip3f9RTS6rDwGf6KAjgeYCgjIIPypfnnU6t9ft3We9Ldm3jqIfh817PyvtCMi2Fm1o/mPvKuRk+VWvQjZ+Ni01pIfef7EWD58fDOddcxfmFRjj/jC13Nt3SMf7Nb0crPJjTvmf03h/X1br7Kes21Spxc8gWQvf/BMcsT5AC/AYkzxJ1vwItzF3JqxvUllqI9M9OzdcJ40V9fZQ87mHvxE2TkGO4r8wUSlUJpNq5FlKNalkggjXPevoXRzjloagl+Rx67myx6wVndQyosR9UaMlwTbEnoTrXenaLtPDeA4vlCo7J+fs8NyKovn06NvcXyww3j/cihhXyNbb3KYdUPtO9EiuMk/s32ziIZUQ/nv9jcXMQ20OZjwYWKoo8sz49qx5Crv7iMkgsfiKRVjWqr4lHo2Ov1plWTaNtHksytP9KuXdIh8z50bYEA8ulvYHzbEG2L1Ivg84YArzlsMsUMyd6qtqdYoWmj/679U7rAkVgGMvBjp1SWD17ktYunQaoZ/I3uu2uLANl80s50AP2ephHdMrFgJ4/+XRZAMILbFA4mw9BeelGAaQSOFKuSsGl1Z6uZryLG05sU9Ewt0fzszYMyTGzeQK+8M3B6BhKGv3s68+fVUr0bW51oKjp5R83ABdpjewYQvWuz1SY9PtsXZuwOWaUZt+mcOKU+sI8cpTxYvtOP4PpmDq3gPYrm5F8mK5xBebz1C4127E/+Vrss1UFZ27eLDB55fdcm9KU7gc57CFa8vnKkmPO9QXWXydz+WJ70GmN92wH0mhpHH1uPyt/mABnmRCXbE1QqyYfqHzqnfF6IJE6P9QVK5Ur1WNT2P3sYZXdq8imdOt6IJjZk1Lt9QfQgh2Sug8pjaJnRsLU2NZxRckqNrpNOWeqf/njBcidbhd46tYYdGghSAKd7pYepZOT1IlGcXnhS29d3PS62qpZD0eJlH3ZE0nl/pD8ovFrakc8lVVcd7/L+qB6tCZqvMCLDYO68A5hD6VERRj8qVrZm+nnY2iMfYWFqxJ2eLOOpRIkSplcpr4nTVX5xtPoGTi3sbEUQrVmF13ZTzCeh3K1o4VItFdMlije33fqNGRt27SiGAxvOBlROa0jOQxiOdrPs6w+hWd1Xl59boejPsWkoR7bK5ChdE+shA0aVs/bdhLzu7h75NuHcnUZpG4fPX15tbKvrjkqvyD9mEhFj2D/G440fzCfGK4Vf3FX7y1P9yFz/jn8z2pKhlIPHv/Dys/3zMGn3076KUyMDmjUdcKhVkbm7FOUHg0uoF+s5hNmlrpKdkFpm8UQtgQgr5S8iWFQKRvKSFiW9UzZrzE9Dy1IfdFOMzPamdM3o9O7WrNJ9vqSiUG4jh75NsTQFl2C+khIJIATkLpsx+GKqdNPxi+oW7QEfD2GbVu/aJMjBcTYXrd6WUqFi5oorNhwW5NlraBfFIrZ1D+tUvXc5vyO7tr/1DJU8p9gyIr/KkzFsKMJBigjxZnFQF4/i82H9wUPAFDbJmlYSZ9FRJz3jDadNyIYz6W1EdAhx99uzet+lE9BTKIfxKyN7vTPj+u+AVGuZVjFstOaETI/9z5+N4fWX4j3NJDRjPZT6T76e74iq897McrS7xrGb7WtjPVkxgnq1wo38YI8fsWHTP5SH141DB85fCwtMM2884Ye7mlgcXrIqTsmrlVKSkS8plZae+Ph7VF3gpyBibkKBqRM7BSB+FW5R2pSkSjWleLDx6sNbzXck8UsrgjMFGPsQ9OjZbS3xv9Df4zw99yxPuRijeQyt6VlXKlCfU+uIbvQmtYghgfoYOEZIjCVTcfRhiCD2KhoJYmti61YOpxcRJai17XnVYGtKO8uLnE+peu1DuZxSEmOINniSY5Zu24npUrd/3HJKAZT7r9YvpJ5yhU2YQfwTG0v/Jsosk2D1QaedWGYFS7Xda9dy/bc++z83ZJZT+4DfchZdecgRip8wFF/Wmxw67fNLy/7z58wxXZcGJdAa3ay2fzRQzWv4pFdVp7jVXcSWbc7KO61437qqrfvKGb1mztZUTdiUulClrgi05rVT1XwPvieNpGRXrPb4ki7Ge0EdWrUqnIvF5zlHWe1XdWx0tL1AT+uPHw8aG/l4h28uUtIiUUc5RNEyenTm9vQSj21G742iBIhhb7Sbzgea4PUtzcPPt2a6sS1rZZY3DtRSRg0MZbzIAOimqgifgqVlbkMvLqhE/S0lupXmmav/tu3QxQVJGPAq4z2/S1raUZw2eiXq/tnl7eQ8dNwOjIda0Ta8b/3Mb0k6IJtg+Zk3EMIuk17iGdbRyII+v/i07AL0QrTPJ2MKXZvWps+dcrRHj33d+kE1bx7/h/ghz9bf4Bjhco5dSWb9UoRVD4DE585FMR6UwZl+5Ms/A7VlVjszvB4eRs3Ou5GNl0Up9ZmquW5VzhGGMb6nxOIWnBv1SduhTcn41fWC2McLR4S2+SAWF/apHDktMO9S7vWn/oWU3cLjq1xFCHoWvk3D0Tx8WdApHK41DesJYH7n3kP0tlcYffJ/OmeEJRJTUkYdSiGnGgDNIQGcuQEDqrMo1bfxLm28LeKSykpZeuvExswWi7d9BEPrvthXVvMl05ooANTHsWiFLmfHhp2STC8OpePv3V0Fnlq4lQ36B/c13sH0NOJovyN78bfM4t1lA//U1qIX3rXAV7FmcWpcvdxMPQ4EpDSOIZYbn38vken9zX3WTR3l1ote9qDQ/BTkEe01/wdPzvqLtj1nD189T174AktHEZRsb/zz1OYse1i1PlVa6Voz5/OPsGjOWQqb50GRrJiWjexUJ9N6/fIdGQe9q07p4dFIDvVETsjy4D4lko8tiNnco5NUavtgzN+ZHtkiDrWc1l9ebJ9f5ojS4/jt4KJZix+ySqC0fSomxxvwXLfpZvTW26uroCJKljoFadlnz8ZI8HQHqlkrmTX8AHVBNWHXXG+LqDKoslDwTWUmmloz6IdkaArF9lFDJoPJLymkBKBBu9na+dG283jtiF3Dt5pDPXqvMHXMUb40qH5LunNOOcwuZWstDqHLelE3oXk3iRSf5V0tNrrkxviej4S0RW9r7ymHFk14UdIuRV64xhB6ZyC9vINi0/z3JM7Pf53HW+GdJc0P0fWML4dfJaWFYcRTP3/qHuUm0MsW/H6eCUDX07ZSzui/4get3e64Ni8WSitDuhAGaOOi+c2e/rRmCWqEjFMb7VU1y/QpyL3CpzscHqjjRav4ogh43gTFmW+RJWpsgSK1UL25SsKacWwYfFQv5OA7F+ewqSKb0dtJqP3uO0sc+ZbW3x6u1d6+S6ZNxArj2jeI5tc4Tk5FQxRrehSavy1fxNo5t6A9h2JVHXerEYXjFLZybCHa1+8i1NJjfmVWDQXkkLa+HRnJF7B6k8MGP5GrdAe+BP6OUnZpLJUejs1dQ9vdYud6qXjWp2UtFKX/qf3fAFlZN5O9+LEWIUg5v50uEixMplmdD6nVkYFedpnq8Pli/Zb2x7Kxh1bn8fXmw6xnRl2/S8Xs4ABHjPJtMvfQKdzfD562kypi7M/T7aBNRYeLyeeLVrSWt1te/U8xOvutmZBBkk5aXOdQQg1t1uiFjZdXKGtiFECaGhbR9ehHtN6FxkwfsjxPp2LT4zPq+/diIkSpHuhDK/8FABRjNSCyjCeZXvr967K1s6rMtyydtK8QzakDYdDqAEk0iQXaCVZytnO/DnQZmsT0xkYnu7g0GZaREQjgeNlRKFugNKiWmiX0SPdqCp3Gdxy1V7dqU1bbnHNbQMhHJwXCQvH5EibG1xWXKMwRp4biJzcyRk+fG63pUZ7Bx4bn2GMJF52VR7VSCuSsivP18Vv9H1iPcsv5VJw3EMC4kYvPEj2rIQSXBabSuX0tppIDZEjzwwz0H3lmf6+CtxPv4zu0ZYZUlhYu6kf3Lq20Xan5arHUj51nZS2jPbUWduOaLRMqpx4bI7qQz36XFv31izyjUopdxFm9meWFXQYUFeGzxv/gn8LVhvb6wrJofJzhI3Vm90qpKKTdfOmBEshzZGEJsr9ZttpKNxhOcfMA2OYDanJUa21KCxzS+Y1SOvfCOoxKLN44BEM4zprV62P1O2UJAokprhMzdUSmm9jphdqbx23nIObSvW5Oy+qO/NneSA4ObRU+lRQoQaN4vwmwk2qPRkNab2UhDgS/7eprF277ZArX1qS8+ffE8y+mNSl365vZuupJFt65PmVo8WFThY64+zGFPuZ85H5rfw9MMmBa678oWHvPm4v22B8MnezWCvl43+N7WhH3D/co4nl0UzYsQ4/v+GZ9dzu+bavHgNXe/9AT3sz6nQYMsxHBY36RfNxZaDa/wW4o9RmV5lvTIVOsvlan1beOvD9CPT1KHHfNaI/V4X13o0rlPVVWFVeH9qfVL6OElpFUW+zho99mLZsXuf8iRh7XexZv29vkwrKE/chdyju2CQ5Bjo3hrDbKNzJmeREGtCEGCpOo/HArZbP26sDn5rNK+zWUlhkroDNjCOZG/fUYTW3J8jyCik/RnwJJtVGUSvQ0n80rv/9U6UjKWyUg9nmsxru24gLoZtNcJSupLB3iUc8M5Lh/No893vG8VFw7Ynd10K6Ru45ve/Qa6yUY0tp2DvIh7Rvzd6Pb+tYtJVGqQD+Ici/B1uPZfmzi93zOu+31cKLSH2s107Z/MMwI5J/tOC2zCRI56EG/BXTIZ+uUzO4YGT6xxDibCJeisWmQBrpGCX5lvlO51s2Cz6vgMnZZm0UXaw3WyluPkijveAe/fY/nVCP56JWdw3oqe5YeZbsYZqgdmlV1lu//IEYOgrfGWlxticuxwZoj3YFTBUMio6pzskeWLs1zMM17tJmVI0+kpWv1KPUtlRIpMdNXj5Zsq+mBlppNA60b+F1bx7v4MfMqHPoGO37u2Wnynfh8/WgkI+peQ+0SrMnzvXRZlm60lbxS5eO/2/vWU67oXS6fuJ6MAa96vj4crFPPjTIq+/n8s8nk+sWhj6v/sCgC69hXvP/8MvaRJGiNep1VJ5r2r6vzLGODmoGqy/o9nk+lLy9p1Shq8U9tGnV3BEUWPupvWeX+iTnL26n3TQj5fKNQaeOt5Y3MIhKUrdjs/J67mcUq82mEDiKOjGK1KKECxzaCML/oiqD2t+wttO9u011AtVSntsddmR/NU6aUQgGpbJwzis0315uw+kA3Yy7uFzIqmgE9vHJXW5CcLVFaHjnhsDPqfLy08eTQAR3mzVIaw9OZema3T0RkHJWpmNokVVMbtza87Y0hUa/faoiobK3zPQMYpKcUD1xv1C1Ox0bw+rNROsKUKLK03RDj3+UCmxaXZJtvv+Nsetyz2eskn3/bRrXoZX/+nFJadj+3nRzhZn5+e92D6s62gtZof7quocW55MvhieO5MMxLebo/7RUcD3Jae2VfAgqw1g4K1/7l85fCtFxf1K/qx5Kg4Dxvil5EJ0oaSkR/rDpqSO1K9VVENyzLU5ArX1hGI0WNvhNZbJZ7qmWsWjQpR0p9e453vtRsQpobzcgWp7B3eqnbEDdbrzc2prc5ev0tnqtvhCFPvg2IolhD4fL+hf4+bFI+XiiqFp8ZU5g8bVj0J7PeXesKOX77DPWOuquVKpn1Pe+aVAAdG30+GgDqF+3tYJVyJs1SbewBKzEL30yOnM8o9Ggnm2WX0DaVQNLUsW6rGeVtjVJfv4SOnRmI+Y3+OD4eVB9Ub4q27EZFN8wupUgWkRpB80/lN9y77kutPsDFpijW60b1/pt1x3vyXl9k9hpJkas9/Wn72uOZ9PzAuklfLab87HV/sHntKe5xbWDuHN4NJ20offpvwByfvpWKqOIob1D3pwWxOn4evoqsrTRHsVw7sxI+v/4RzJ12DsslS2IxzJniM+hLEb0qClq4Lg5im0UqMmm7pWWeXx+Q60E5qnD0dMzms8k77MhtdUWg4jm1tejWtxLv2zZj1gvRvlj9zeI0hbbJLOG4fEh0xm7VXWlqs720svDaTr3MN2ivbROAK6DoimPWB/UF/lq1ma/beuDJXniDKxvPlyAU0wyGXINQHHPTKDHvHy69yYW2KTBvTKMAkMFq8+w2UrzGLFHUtnYPY+En09ia1qxZUxAK4OdLlWx9R1y1dEEsunFa2D+17G7xQlCP8UvvwQce+4zXUpeF26VFS792bDvd3Mr6/RCLfZpi/8drmmM9Y/ieQzBpnxzH2lHotHMDWtd74D7eSxUlBYXu9ebJvNf78wVGtXgBGjYkT/9i5lKDQwI+1BC1C7yRBjBlNElGvX2VLmi9a/UGTbTKTpnFKNn1rPkN5n0++Hu5jB8W3niQc521y/XG+9dlozNmcesCSlQvfmq/HccXdey6kT0MCEXfF7HneqwWFxV0rLt7fX0qWlatWWHvB8LLmi09oVay+LBzx8p9strKSXoWDThWL4rwdVejrlyfPES0Z1hk5vSkuLYk0B2z+THw9V0xpbr51QTTjjJJT7efenM7ug3BFNR52RVe/NzHbib2JNHUMfrvuHz8V/4j+Kz9kTj+LcDQ38h5FyXAEoCl/dN2eX3ZeIei3yRJuW4BTknOJSEfNT9/K2XwLN/WHjXvJZrmsX77uDs9ffO5P8N6D9O8viz0HL/AjJeGTy97SRx3o2G6m526qGco0hGlcejyQ2ZYvVcpL1XT8VtLeRQBRF7CpWJ/jJZrnKKqJU2O4nzEMo2BKWcVvKSMZ1P2V3UzZvknz1/L5Gp8hjVyRPMjpK3fsbtyzzayHFWHhYzSvkcWAa7enyDv7SESvsCVJcLb+A3Q/83SnSXJDSTLgrXBRwCRSdbb/xa7iswIwN3G/uBdBEQg6qZHtbStkDWHYK3Z7yuFC+nR3tFvlKA+MdQKe6NgS3A8P6dKieMmbhvH1uqQoFiuDdVVxkPrWgBm7FezLdN4frwwv5Mf/fa9d1kAArP4PZ+dr+ratOnIA3r/fP+d0e9UTeSo/oZiXGw2mxmYhzJwANQAwMh8olHT2HVNw/iVqqmnTlMiWpZw5XoRj/epJvGwr1LPzM0BWHY3xtsKQnmwRhhJApBViSNbMaM4PycpZPXUqvyMWhUsNTRfAtCpPm5wPqGgBs3E9HIF2o1oD4PS9Ch3R35DyLmgKDm12gpbjwBjXPkSr09fjXRC2Tp1RPv5hxKMiVrprL6hqHGgj5L901kEasixDenuOwp/rqeSLELvMsD5yVK83xOxYOx+2xwRpgBTa3s3KKHUCCviM59Sd1q3dA5LGDIMFQvumRs1y5SU8TRwaJooWVapSBR5CbadTlnmxvIBOKNCeYTjvDtVUm06GWe/aUohhxrAZTELwC43NInXJ2T6jatqkma17l4U/Sz7+qTKkRGMu4NUn3nsQ0fTkwxV69Gy7+97vic6z3s+AHF+oA4F9ly7jb+UePQFbLaPutzIwqzjzbWnULZ4Is/FV9XjRiJ2zWkph8q1YCw4NvrJW449PQ8u5gPloCYlpdVgourxb6HTrvawpzcPA1cat/SI6w1ZS6KVXD6aV/TgfeTCUkMhQNtDPchIRV2EoXeqJ/HH6tCxIdKhmBYzr7MHFB69fK5PV9P6lLqPVr1khPc7m3H/zMdrGBaMVOq1GACwywwLPvyJERFjsWI0qqtqzuqAVLYCNCApY5eIFglWLBE6IQ4dHcjs2iCAqwYHMunr8xLQ7LTrlyHVTffw16M47vPv+eSgMTNfbR1S5KvNPbB/IOcYW9jPttKlvKDW4pp+lL+4GdrrR6y0nLeNymXNlI4lG2//JbEjaEoKFrCWNSGA5bXnB2gdT2v55kMAHsoaUOtfrh7YbGrbCduKnrgBxqeNt3Uiw9h+hSQUidzQA7NkQAuwYqzNOLg9pzQHZWe1Hkw7hkXRSt4sIk4twAFZXAAt6oaJoB5VitPqvjSgGSkUBKGMXu4Lud7XTohHhGGM9vs9PpjMoQnQu/UFjYxasop7PAJ6LGoFx9Zkezxy7l4BuMDDpfYnRuGbo7qIjcYYARxMqHYVeKKRTA1w12l53JK118AyJvPzuskT6uKZr9qhtSd13ECrlnW+cUCUWsNxTqg/ILVANvPwI7ZfyD4/FOUecr3PpWe+vWrVJ326rsE3JL7uZ0NRMPkirP1vZ8OIX0s3cBaHB+r5XJ+xwbWnxRnOsfN+WTVv13P9b67as0/NQfKtnL3SfkW/wQ/qS4aNJhhQLqsNIsGPsgQo6/WAQIf5YEHud9es3KFUgZdgMvbmlt7Y0YE1jGLe/dGy5o1YN00FtLQaVuaHYaew9azi5MA5q0N256FeGQ0z/fIQLwGoUCp608yzxjpuvgERW3/jIwyjHAbol9U7SgAABjqoTXSyqpAzEY97gGHFJq1qQFbC/vZR7tGs2VMB2vsqxg0drD3FKZtENIjg3R3X1Dj0oGGebJceBmKueztTzciXnKvxB+8jUUtZ8LprgCmCQcb5HuPIn/mpL9B4bXVgE7/GE1OqBNbW7j5211izb9fauVRUtxpX3zUdIE42iF1Xib3rU8tnGLwyv1b+8vEDqxnzxfUNsTxNz/X6yVFZFiwcO+Znexqq79Or3wGl8QaI5A2DngZYRnu8GnoJlsLWm4bP0ts7FGB+Qi7f3UpIPjBlVEWvt/EsnuHedtbDYZ/3oXHtDKMMZK/kAKdX0gkGV1rfTbrC9M5PvARwPvm6QzuUViG9tKqFMD0c7Cz0qIGdrD4QH1VfwlAbN+juRAbT8GpAQQ3LBndkdLAzrLZnEj4ZpGU3qOkmjXeGSMrRqFg0ejNBjBKMMqS01h1Ls0pJggUDUkL90KYyFkv1eUgvyY+/8K5Po7R4acbhRUG+QvDoAic4cxNByMJNNkCLNiW5He/9JcjPiT4jrWA8DadhxLkuy1vy60DUG2wMiLJtWnSy44H5AJ+rK7hepmeOvzPSZ0j7WAJ8pZ+wCx97R54LGvVGHxhpNdivxPY+SHU3j2tZHNqeWmlfP9htJeWxB0RzhWHnp5lWrn694Zhrg6c1LVMoQpIvh8n5NOlNA0emYl2gwytUQype09Gg9E8aGlhCeShTipaSEAvON88tiZunIG+zpgVyAfqwWg4yqT6Iel3eNXJD2Y8JQzuPS2203RQUQNi0iwXNykhce5P29GUAgsMmN61kaV2BdVSdBl1WZlWV0RG2GqdnRZMood4osgoHSsvDpkGvC1rMHQ7FULl9asgIA08F3CPS6310Cot/VUurFpKlfV5/x48DnLGxBza8mxcdK+BYx3tsQDi7+YH7192ek459Sb7Nv0f/kWpHk8DEs8SoGzDoeBMgwtiqMX0KUGWS74wRLXvdef5Q/rvM883pA7iEOen4VFGMU6G2D1+PtIc8F8R1O0VY+0w5HqGIiFaXe9003zjYNlLCa4dL0cyEGmFlC/QC69TxsHfgrq/7cnqqo0LxSg7toWml6UlheewGGOFoAShQNkyq6VKtOOcIjYApfQFBLkoduY7kurpFlMD9b4xvACc2EKUEOPsdkEEZBW9AsjsRygZ4PTwz+CPBBJk10qfr9YHXHcdOnyO1fprniYReMl4VVgFl1ECoGT7Qs1uH3dysOoCl03hjxRgL6CJgn7HgQChpu1nNwHqkQml2vhsGWXcwJGV3a+oQTgaO55/XD5xcl4UlqIfRAp2ffsP33p42V3+UE9vxR30CFXt90uHQdFKa+/xUbT7enqvPjzE9D8J6wRS3DfAVy34t9fmUzMT+wXOB1vGZYQzh3eCigAKHUkk2Q2vOURs+msOMkBTKPYTLIe74tQMmHsHVeeXJD9m8B6pPD/BAL3gP6Xqqt33opa3t6OKhiSPrQge4LOAwGJYjxRLOBd6Vtg8DlgEBUOy0HGHjM5MSKHNWvkWEobZagWF3T4Bp2mhsyDNdj13NSqv8tBkLEjmrwiyfWb2BV6X5c7W7dvfM9q5hWRS0uHLR/uQ6Io5VsaVbs+vuwJIi4MSdOOBl567Vir68WY0dp2B2EXFxh2NzPXjNXV+xYWzXjHS4puBrTQWd7Xi+SnbF+yAHTUiYxQQO/2p7xAKFSw1Yxj4FYFiDe1jWLa8lv+QUhcbBZxx/QCFy47TXZ/9qKQEA339tbGxoYytcqxZLmHNs09rqhivvc2ctLalRfdJ5DZNa1OrkWndA6CGUg60bF4PYBzQQzPFkPTDMTOqCWgX1uI9HX7492JN5EQrkufp4TjM54jm0r64wg8qTlzBWydeHk6ESNvSCXUtiACnAWWIDZBy4oRE9IO1dyCnAXFw3Qz9bb7SLHH6E0LyP96EFsbdNjfS4Q07EdUDb6q21W9rDfAc6TSvgbuqjq0Emnx+AwjHEKlHRHomFrPKGQxU8sGMmTlJKJFhp1O5jQeyqzE3tXEFBWSPr9bfA2jo+0+oN5YESX9UA+F3mT9Io6vHgeFSBQy1hsGlfO75aSn0fd8WDBn1+r69SBK2EHV7qguMD599jfF4WlOfT3Pb+F8gAYMhFuXZ2n+bxazlEXnc3SOSHPHv8fJejfrqlUKQHQ1UUAogjhnfayiV5Wy0JPRfkvKvZBCoCdR/v1oRtggka+9kQMHZC6usDiNQVPU8x8H+Oo8klArSphJN5aWvC3SpJcTkFuhAAIwJYzSTrGHAJzIfkKjkxbjhutkNAwa0J5MRc65/3XtvqAk00q7O2el/LXDdb+2CBnjuzmRqeKlGtCVhrMmvdoGQlJm0tcQjhOrADbRvRb64NFlD7ZGrCvgwhYHPx6ynjgelN+fJVSw4tUTXYkql2uQTo6HfPyFn6NtSv8K9d+gfsu9zgRSG2AvE/GhZiGpxKCwIVvlwTF8mB8y+4Zp6AyJ5RDhezyruDRLGsCU2juhFmH7t7bXZhwwfpUKaD6PjjhwIeKDPMGRyufJJYmT4v4cxM4AZWU+aTc6XsY8M0T0fRgHTAVooGqDHPHS/kD5ABQIfu+rVgccfpcHgicWgceqhiwtnkpAjoyohDj9tJe889ch2r3JRZF5lnNVBTNegr/JBMAG9epJTPAWmnKBVjiKMqOE3V/ieWMLQyS5fRzOFIT4BcJ9QEzKQNr7dL4bLc4TQBCMlmANpzmzszaP23XlKeXpqA6vy0/mAQJwBb9YI6OGDsHF5jQhaEB+a76rl2YGh/MiccuA/I8A1yGgeKHYKzeGGqQuaReYRv+wXeu1ylWCP2+XRsnInM0gwc8CBma/34gezQi3e52w+cYwqU5hdh2XDUzf6I6/c9H+g+FG2ed2m7fvQ7Nzg3v2NgzRP7j+WZVnvb0NS4gazanosmKcBxQ3875yH7W0Z9TlwXVZ8dveDE5rvtL2A3raOqLYjewHAHCQTvc2m5k9uuEuAH3QOGtAAtuMqm9BhhBRb3Lp5w3Fb9RLJsGYzFe+Ehgx309KwSZexjUSvSBVjdGhx3V5xLSrfzM8n834PL1Tkh6z7bw50k/fyQQAyDHPjwiCIYE6LKpIGZxU67lDMT3IFKZbNrVe1wd7kYjNLzWBC4DNzTYTx9UNGpeMiKfjuAp0UdwWccD8DI+jOalM0+uwswO8+I2GV3floIBB7weI3xbrFlfjCjbL8krtsunWLesJQXH3+2SJisc82PT6TlIPD1v9UfA/Vi4l+JoJTnMfbG7OcnJ6xLdm3F7eSQokVbWofbkIDnhu14/lh++RrOIXXrIQ1uzuMOLI1QBOY7sZvp66ffOR+FqGJMznQ7vLzzu+WGFz19vdYwO6JWk5cAXLJfN2dDoEL+FO5aIkMpAK4EtwAYqDA4DGK+kZGVEZKqUz4FN/J1B2hv4pi95IMbhhnUpIeUxxte9PB+idfPts3Q+IUxBKJFNAeH4x4+NxgAFAFoVFGnIFqaVyFm0/P23goTNaCdioVggQ2QA+5GKLVYjE1YiRM6P1VUFHql1NpJS60wqxfV8aHahiOlF8d0OGDVTLeY77ZhSFtorUvvwAu+wCioV/XvJO4wPg4dPTpteMWGHrKOlhefaIbDO/1VaseGaTPiSv2OYhfFQu5J67nkt8cNMHpzULNSYuXObtHw+br10MjjDytQXqGz03vutI7ykjCRV3rLICy313J+oGVjMOkaVdmvgkMamPnlUZfluLtWBh0bpgZT9J8OPjWyW5VBQQm7LRhlRUTC1DoVFCDLCUq1PGX1Zo7VWZkss67haInVulkJwKKZdYEmHOoYgIaFEBYe7zg3SGbSrcIwK9WubbNJdFzQZGQNvzwvXtQHblzIEtSmH+lgQ65Pc3EBD47WWHvfQ+BaftL7uG1Kgp8aGazN0BwSAJGl4u5LyY9dtoKrF8x27x3drXm5Ha7tMPYkKGXQ7t0lbZR9PTrK/sL1SmOB1xr8MMEN8PVTA1dRkEGWRedD2uwz9aSSsg59PQPHbaYpSExhMtf1nPAU+RX9L5HBrz9uvABBTfNrzXLW5yXxlQt/3QuUM6EXy35fd8KEvvvwrvVp4zEsrOUge+DUM98d3QMGbsjN99wKw/5lnFNj7Bh7vsETmRqSWIQmRNGiNhnMUuH6yFQomISmhzNaCSrlo1ZwPHaAVXduDDSibhCOnk5sUTphF3CIQ0lOkp6VFTU6DlDcw6FM/vyDhsZVLHFAyax37XuULXl6E/McsgsFmwEk0dbWSaU9AMMQIk9Xl2IuaMEk7NEeHjdWq6tmgrMeDakbTMNOG2WUwuU5fBgADPWZ/3Y1KFT62byhSpEOYM8GT+OcAtsh+dNuN9CS4Qtk5/G20o2N/TiwCdioWw91+5WkbG7bstT+0z4DDjR4nXeIFogVlfBT6fXOJ7+02sKvz+Ap8FUU9+8N9oF/5TDAQ+BXX1d5eFiAXnF9dEMtn6M/5z0iMzTMeV+xT8MYn18LgXuggQ/W17YXbGrtEAEtIW6nUkGsb5MDHYhPKYdAy1w02xAZDbVYQXcYiOAZzdwYc2IqlqptZ6hGN20aUCYBIY9e7vFBR6iRwy8goCKZ3YCMSIdZR8u0fw8uhX8JgESzus7V1GQqF/4MxSzkau586NVAeD6GlAGQjEP6v2am1Szek4D1tM19T+s6wZOSoD9tRYUYxfWI3t4dHgON0tAA+HpXwUPL3PES3xV8c2Go6hxXREC2nb3rOFgzO1QlCPhuAn0dpaMdpt/xY3QOKzefnyizfHpZ7L/Wr9VuKdZEwa4Of+blXz/xy3HWv6/Hxp0MzTbCeJ9v3wAiAGhxlJhL5jqe+dkt1ioo41luA6TasQHGg9J2xUXH6LufvlH61P4OPv58dZsiBer1me3Tpi3I/gHjmBtg4uIhRSAPXEMnNgWlfazhzUUEIJ0qhp8+teUqejEJkeb1SW9mAkoJl3RqfL+sDHlsPipiKdC784j+hGDWu7doq0RtWxAaQStuK5cw1NoAIQEDRtv9ge7d2i1VIPnfAAwMQ7CyQ0+POGQgYMf2tBqh0CsM1VGf2Z6BCpnH50IpAz2zKyXJULWOD+IaD8UBcd41JoajDb28uQAIFCoIHpccn6PucV+lWUOH482Rn0xwVHg9c1LKr6cMu/X7T8KOTKuk8bKmGTXm39m9/9T7LA7QKpXGzyOXtPq/Cz+Rq9AN7TN0+uOHdnA2eGH8WvDL5967RCmD+REAB8R5Xx/47rw81MaGr58o8EzTnBJutMfsokJxbC30KSE4SiRRPKQhBxv2FTyyDzGH7Dty0F2DeeH2gbV9aNcd5ahIllY21OKa7T4WtC0QnAmsNQLo9Da08tbmVuV4FwfOPixewlbV+4roSJTNHqK+S1gAufnMUNClwtDbWZvPKaUIil24"
B64 .= "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"
B64 .= "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"
B64 .= "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"
B64 .= "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"
B64 .= "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"
B64 .= "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_closebutton_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 1832 << !!A_IsUnicode)
B64 := "iVBORw0KGgoAAAANSUhEUgAAACYAAAAmCAQAAAACNCElAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfmBQkLFzHhKfmIAAAEZklEQVRIx9WWXWwUVRTHf3dmZ7pf9FM+yro1hBYqtRalFKJCkShF5cEopvEFI0iior75YkIIQQmJD/pkQiRAMBpJAKW0gQRNrEC0pGBbBAV0MbRQoJVtu+2yHzNzfeh0uzuzFEl88dyXmXvP/d3/vefcMwP/oYmpBof9vy66VRMNJQotVTX80dKrs7tqz+nGfcM6njj9TG/DzSejxXEUBBIIUto3q6Pi9PIj1b/9a1jPoqOvdTffmOHBh46GQCKwSJMijqDiYv1Xz3/x0JV7wobU9g2HtvTODhLEJEUaE4lEoKCiUYAkRoLqnpe3rPx2SthgYO/2Y5u86jRSxLEA6XJX8eMhimesefO6T7JH1eyX276dO1s3BpUCYiQy07MbgCSJQYCE3tX0AS3teWHD6p6Pj24sQbU1TRVoizRBFLobP7p1sHOiV5l0OL6u7d0ggjhWRsXdUkBgEkdHEV/u+LnRBete3LpVExrxe2ianGgSx0+y8Osd10M5sJRycn0k7OWO48CnMoFJCi/dS7vW5MAu1//YHCCJ6VAlkTZeIrFcsTUwKeDwe7dnZsF+Wn29RMdyHbOCF4GBBArQMV0+oHF5wdklGdhQ4FKDStpxWhIoopKHCZBEJ0wNs0g71FmYSHoaM7Cehf0NOqZjgwqlhKjnbV6gjDKqeJU3mOvQJrHQ+XPN+TB4APrrBqYrZGe7RKJRzmIaKWcGs+njceoQjPA5iZxcF0iuz4vOpdcDMFQ8QnHOigIYY5gayoEiVhGlGEEfF0jlSZMoo8W2sngg4XIQSCK08ADlgM5M4A/2cgoFzbFRwRiJafaZSeGOEeiYnOAHRjM9t7hIYnx9B87EUm2Yx1Sw7JzKbqU8SJThzKQFPEepXZKym4WKatqwwKgPw7GWhUaIOuopyfQWs5YXccYdDIL4Yjas8O+gw0EAKRSW0YCfCMe5CYCfgOsegEVJ2j9gw+adKbvmFA9JIkSwuMEePmU3Axgc5ABJFNc2w2fmXLKjOf98RceVl7w5Kwo0htnHCH2cJE4bkpkc4SZB+/MyGXWDed+HJpR5U/M7ceSPROBjkF0cBYpQaWM3gwRwlvIUXqpPjucbAMsOz7l6B2clE3hR0fEg0dHR8LlqnUmS2vb6jixY5YWn949XByungYZqP6t4HKNyXJfZtKcomgWDFZ/V/RLDums9I+tp0tIkeKplyYHxtwys6q+126Ybw/dVaS1GqLzRvLVszAGDZ795/f2AGct7F9wNDEYIjWzaWNs9Qcj5bu4/rctzK0aFlhP8fKaQZpTQ0Ia3mg5N9ubcWtUyP9Rj+7YPeD1oCFcSYMfbIolJVf87by5rcY457MTq/Zs7lxqKBw+K7TChVGJiYOJPLW9t3lbb5V7IZZfDna98t/5izcQviwdh13oF0M2Fp1bterQtfDuf6rwWqTq35MLqyGP9C2KksFApoMgKna0888ix6o5wf/74TmFxrbfiavWdwmSBhSp9Cf9g5e/ha/wP7R9PVNdgAZ4y4wAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0wNS0wOVQxMToyMzo0OSswMDowMCMtXQ4AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMDUtMDlUMTE6MjM6NDkrMDA6MDBScOWyAAAAAElFTkSuQmCC"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_buttonon_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 5636 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_buttonoff_png(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 5556 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_ap50_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 4140 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_attack_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 4080 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_hp_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 3620 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_loot_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 4244 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_mp_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 3600 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_otoattack_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 3516 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

Create_str30_bmp(NewHandle := False) {
Static hBitmap := 0
If (NewHandle)
   hBitmap := 0
If (hBitmap)
   Return hBitmap
VarSetCapacity(B64, 3616 << !!A_IsUnicode)
B64 := "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"
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
VarSetCapacity(Dec, DecLen, 0)
If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
   Return False
hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
Return hBitmap
}

;/*
;===========================================
;  FindText - Capture screen image into text and then find it
;  https://autohotkey.com/boards/viewtopic.php?f=6&t=17834
;
;  Author  : FeiYue
;  Version : 8.8
;  Date    : 2022-03-22
;
;  Usage:  (required AHK v1.1.31+)
;  1. Capture the image to text string.
;  2. Test find the text string on full Screen.
;  3. When test is successful, you may copy the code
;     and paste it into your own script.
;     Note: Copy the "FindText()" function and the following
;     functions and paste it into your own script Just once.
;  4. The more recommended way is to save the script as
;     "FindText.ahk" and copy it to the "Lib" subdirectory
;     of AHK program, instead of copying the "FindText()"
;     function and the following functions, add a line to
;     the beginning of your script: #Include <FindText>
;  5. If you want to call a method in the "FindTextClass" class,
;     use the parameterless FindText() to get the default object
;
;===========================================
;*/

FindText(ByRef x:="FindTextObject", ByRef y:="", args*)
{
  static obj:=new FindTextClass()
  if (x=="FindTextObject")
    return obj
  else
    return obj.FindText(x, y, args*)
}

Class FindTextClass
{  ;// Class Begin

static bind:=[], bits:=[], Lib:=[], Cursor:=0

__New()
{
  this.bind:=[], this.bits:=[], this.Lib:=[], this.Cursor:=0
}

__Delete()
{
  if (this.bits.hBM)
    DllCall("DeleteObject", "Ptr",this.bits.hBM)
}

FindText(ByRef OutputX:="", ByRef OutputY:=""
  , x1:=0, y1:=0, x2:=0, y2:=0, err1:=0, err0:=0
  , text:="", ScreenShot:=1, FindAll:=1
  , JoinText:=0, offsetX:=20, offsetY:=10, dir:=1)
{
  local
  if RegExMatch(OutputX, "i)^\s*wait[10]?\s*$")
  {
    found:=!InStr(OutputX,"0"), time:=OutputY
    , timeout:=A_TickCount+Round(Abs(time)*1000)
    , OutputX:=OutputY:=""
    Loop
    {
      ok:=this.FindText(OutputX, OutputY
        , x1, y1, x2, y2, err1, err0
        , text, ScreenShot, FindAll
        , JoinText, offsetX, offsetY, dir)
      if (found and ok)
        return ok
      else if (!found and !ok)
        return 1
      if (time>=0 and A_TickCount>=timeout)
        Break
      Sleep, 100
    }
    return 0
  }
  SetBatchLines, % (bch:=A_BatchLines)?"-1":"-1"
  centerX:=Round(x1+x2)//2, centerY:=Round(y1+y2)//2
  if (x1*x1+y1*y1+x2*x2+y2*y2<=0)
    n:=150000, x:=y:=-n, w:=h:=2*n
  else
    x:=Min(x1,x2), y:=Min(y1,y2), w:=Abs(x2-x1)+1, h:=Abs(y2-y1)+1
  bits:=this.GetBitsFromScreen(x,y,w,h,ScreenShot,zx,zy,zw,zh)
  , info:=[]
  Loop Parse, text, |
    if IsObject(j:=this.PicInfo(A_LoopField))
      info.Push(j)
  if (w<1 or h<1 or !(num:=info.Length()) or !bits.Scan0)
  {
    SetBatchLines, %bch%
    return 0
  }
  arr:=[], ini:={zx:zx, zy:zy, zw:zw, zh:zh
    , sx:x-zx, sy:y-zy, sw:w, sh:h, comment:""}, k:=0
  For i,j in info
    k:=Max(k, j[2]*j[3]), ini.comment .= j[11]
  VarSetCapacity(s1, k*4), VarSetCapacity(s0, k*4)
  , VarSetCapacity(ss, 2*(w+2)*(h+2))
  , FindAll:=(dir=9 ? 1 : FindAll)
  , JoinText:=(num=1 ? 0 : JoinText)
  , allpos_max:=(FindAll or JoinText ? 10240 : 1)
  , VarSetCapacity(allpos, allpos_max*8)
  Loop 2
  {
    if (err1=0 and err0=0) and (num>1 or A_Index>1)
      err1:=0.05, err0:=0.05
    Loop % JoinText ? 1 : num
    {
      this.PicFind(arr, ini, info, A_Index, err1, err0
        , FindAll, JoinText, offsetX, offsetY, dir
        , bits, ss, s1, s0, allpos, allpos_max)
      if (!FindAll and arr.Length())
        Break
    }
    if (err1!=0 or err0!=0 or arr.Length() or info[1][12])
      Break
  }
  if (dir=9)
    arr:=this.Sort2(arr, centerX, centerY)
  SetBatchLines, %bch%
  if (arr.Length())
  {
    OutputX:=arr[1].x, OutputY:=arr[1].y
    return arr
  }
  return 0
}

PicFind(arr, ini, info, index, err1, err0
  , FindAll, JoinText, offsetX, offsetY, dir
  , bits, ByRef ss, ByRef s1, ByRef s0
  , ByRef allpos, allpos_max)
{
  local
  static MyFunc:=""
  if (!MyFunc)
  {
    x32:=""
    . "5557565383EC648B6C247883FD050F84AB0800008BB424BC000000C744240C00"
    . "00000085F60F8E1A0D000031FF31C0896C2478C74424080000000031C9C74424"
    . "1400000000897C241089C5908D7426008B5C24108BBC24B80000008B7424148B"
    . "54240C01DF89D829DE8B9C24B800000003B424B400000085DB7E58893C2489EB"
    . "89D7EB198BAC24B000000083C70483C00189548D0083C1013904247429837C24"
    . "780389FA0F45D0803C063175D78BAC24AC00000083C70483C00189549D0083C3"
    . "0139042475D78BB424B80000000174241489DD83442408018BBC24A00000008B"
    . "442408017C24108B9C248C000000015C240C398424BC0000000F8551FFFFFF89"
    . "6C24088B6C2478894C240C31C08B74240839B424C00000008B7C240C0F4DF039"
    . "BC24C4000000897424080F4CC739C68944240C0F4DC683FD038904240F848E08"
    . "00008B84248C0000008BB424980000000FAF84249C000000C1E6028974243401"
    . "F08BB4248C000000894424308B8424A0000000F7D885ED8D0486894424200F85"
    . "800300008B44247CC744241C00000000C744242400000000C1E8100FB6E88B44"
    . "247C0FB6C4894424100FB644247C894424148B8424A0000000C1E0028944242C"
    . "8B8424A400000085C00F8EC60000008B7C24048B442430896C24188BAC24A000"
    . "000085ED0F8E8D0000008BB424880000008B6C242403AC24A800000001C60344"
    . "242C8944242803842488000000894424040FB67E028B4C24180FB6160FB64601"
    . "2B5424142B44241089FB01CF29CB8D8F000400000FAFC00FAFCBC1E00B0FAFCB"
    . "BBFE05000029FB0FAFDA01C10FAFD301CA399424800000000F93450083C60483"
    . "C5013B74240475A98B9C24A0000000015C24248B4424288344241C0103442420"
    . "8B74241C39B424A40000000F854AFFFFFF897C24048B8424A00000002B8424B8"
    . "000000C644244B00C644244A00C744245000000000C744245C00000000894424"
    . "548B8424A40000002B8424BC000000894424388B84248400000083E80183F807"
    . "0F87BC05000083F803894424400F8EB70500008B44245C8B7424508944245089"
    . "74245C8B742454397424500F8F410A00008B4424548B742408C744242C000000"
    . "00894424588B8424AC0000008D04B08B7424408944244C89F083E00189442444"
    . "89F08BB4248800000083E003894424608B44245C8B7C243839F80F8F7E010000"
    . "837C2460018B4C24500F4F4C2458897C24288944241C894C243C8DB600000000"
    . "8B7C24448B44242885FF0F4444241C837C244003894424200F8FC2020000807C"
    . "244A008B44243C894424248B4424240F85CA020000807C244B000F8570030000"
    . "0FAF8424A00000008B14248B5C242085D28D2C180F8E850000008BBC24C40000"
    . "008B9424A800000031C08B9C24C0000000896C24308B4C24088974241801EA89"
    . "7C24148B2C248B7C240C895C2410669039C17E1C8B9C24AC0000008B348301D6"
    . "803E00750B836C2410010F885004000039C77E1C8B9C24B00000008B348301D6"
    . "803E00740B836C2414010F883004000083C00139E875B98B6C24308B7424188B"
    . "44240885C074278BBC24A80000008B8424AC0000008B5C244C8D0C2F8D742600"
    . "8B1083C00401CA39D8C6020075F28B442420038424980000008B5C242C8BBC24"
    . "C80000008904DF8B4424240384249C0000008944DF0483C3013B9C24CC000000"
    . "895C242C7D308344241C01836C2428018B44241C394424380F8DA2FEFFFF8344"
    . "245001836C2458018B442450394424540F8D5AFEFFFF8B44242C83C4645B5E5F"
    . "5DC2580083FD010F847207000083FD020F84DB0400008B44247C0FB67C247CC7"
    . "44242800000000C744242C00000000C1E8100FB6D08B44247C89D50FB6DC8B84"
    . "2480000000C1E8100FB6C88B84248000000029CD01D1896C243889DD894C2410"
    . "0FB6F40FB684248000000029F501DE896C241489FD8974241829C501F8894424"
    . "248B8424A0000000896C241CC1E002894424348B8424A400000085C00F8EF3FC"
    . "FFFF8B4C24308B6C24388B8424A000000085C00F8E880000008B842488000000"
    . "8B54242C039424A800000001C8034C243489CF894C243003BC2488000000EB34"
    . "395C24107C3D394C24147F37394C24187C3189F30FB6F33974241C0F9EC33974"
    . "24240F9DC183C00483C20121D9884AFF39C7741E0FB658020FB648010FB63039"
    . "DD7EBD31C983C00483C201884AFF39C775E28BB424A00000000174242C8B4C24"
    . "308344242801034C24208B442428398424A40000000F854FFFFFFFE935FCFFFF"
    . "8B442420807C244A00894424248B44243C894424208B4424240F8436FDFFFF0F"
    . "AF84248C0000008B1C248B4C242085DB8D2C880F8EF5FDFFFF8BBC24C0000000"
    . "31C9896C24108D76008DBC27000000008B8424AC0000008B5C2410031C888B84"
    . "24B00000008B2C880FB6441E0289EAC1EA100FB6D229D00FB6541E010FB61C1E"
    . "0FAFC03B4424047F2789E80FB6C429C20FAFD23B5424047F1789E80FB6C029C3"
    . "0FAFDB3B5C24047E108DB4260000000083EF010F887701000083C1013B0C2475"
    . "8F896C247CE964FDFFFF8DB6000000000FAF84248C0000008B4C24208D048889"
    . "4424100344247C0FB64C06010FB67C06020FB60406894C24148B0C2489442418"
    . "85C90F8E26FDFFFF8B8424C400000031DB894424348B8424C000000089442430"
    . "8B442404897C2404908DB42600000000395C24087E658B8424AC0000008B4C24"
    . "108B7C2404030C980FB6440E020FB6540E010FB60C0E2B5424142B4C241889C5"
    . "01F829FD8DB8000400000FAFD20FAFFDC1E20B0FAFFDBDFE05000029C50FAFE9"
    . "01FA0FAFCD01D1398C2480000000730B836C2430010F889E000000395C240C7E"
    . "618B8424B00000008B4C24108B7C2404030C980FB6440E020FB6540E010FB60C"
    . "0E2B5424142B4C241889C501F829FD8DB8000400000FAFD20FAFFDC1E20B0FAF"
    . "FDBDFE05000029C50FAFE901FA0FAFCD01D1398C24800000007207836C243401"
    . "783783C3013B1C240F8522FFFFFF89442404E917FCFFFF89F68DBC2700000000"
    . "8B742418E93DFCFFFF8DB42600000000896C247CE92DFCFFFF89442404E924FC"
    . "FFFFC7442440000000008B4424388B7424548944245489742438E944FAFFFF8B"
    . "84248000000031C931F631FF8904248B44247CC744247C000000000FAFC08944"
    . "24048B8424B40000000FB6108D5801EB2789FA8B8C24AC0000000FB7FFC1EA10"
    . "0FAF94248C0000008D14BA31FF8914B10FB61389C183C3010FBEC285C0743A8D"
    . "50D083FA0977078D14BF8D7C50D083F82F74070FB61384D275DB89C883F00185"
    . "C974AE8B8C24B0000000893CB189C10FB61383C60131FFEBBC897C247C83FD05"
    . "8B8424A00000000F9444244A83FD030F9444244B038424980000002B8424B800"
    . "0000894424548B84249C000000038424A40000002B8424BC000000894424388B"
    . "84249C000000C784249C00000000000000894424508B842498000000C7842498"
    . "000000000000008944245CE903F9FFFF8B44247C31D2F7B424B80000000FAF84"
    . "248C0000008D04908944247CE96CFFFFFF8B8424A00000008BB4249C0000000F"
    . "AF8424A400000083EE01038424A800000089742410894424188B8424A0000000"
    . "038424980000008944241C8B84249C000000038424A400000039F00F8C080100"
    . "008BB4249800000083C0012BAC2498000000894424288B44241CC74424240000"
    . "000083EE018974242C8B74241001C50FAFB4248C0000008D7801896C24308974"
    . "24208B44242C3944241C0F8C9B0000008B4C24108B5C24208B742424035C2434"
    . "2BB42498000000039C2488000000C1E91F03742418894C2414EB50908D742600"
    . "398424900000007E4B807C24140075448B4C2410398C24940000007E370FB64B"
    . "FE0FB653FD83C3040FB66BF86BD24B6BC92601D189EAC1E20429EA01CAC1FA07"
    . "8854060183C00139F8741889C2C1EA1F84D274ACC64406010083C00183C30439"
    . "F875E88B7424300174242483442410018B9C248C0000008B442410015C242039"
    . "4424280F8539FFFFFF8B8424A00000008B8C24A400000083C00285C98944241C"
    . "0F8E2FF7FFFF8B8424A40000008B6C2418036C241CC744241801000000C74424"
    . "200000000083C001894424248B8424A0000000896C241483C004894424288B84"
    . "24800000008B9424A000000085D20F8EA40000008B4424148B5C24208B742428"
    . "039C24A800000089C12B8C24A000000089C201C6894C2410908DB42600000000"
    . "0FB642010FB62ABF010000000344247C39E8723D0FB66A0239E872358B4C2410"
    . "0FB669FF39E872290FB66EFF39E872210FB669FE39E872190FB62939E872120F"
    . "B66EFE39E8720A0FB63E39F80F92C189CF89F9834424100183C201880B83C601"
    . "83C3018B4C2410394C241475938BBC24A0000000017C242083442418018B5C24"
    . "1C8B742418015C2414397424240F8532FFFFFF89842480000000E916F6FFFF8B"
    . "44247C8BB424A400000031EDC7442414000000008D48018B8424A0000000C1E1"
    . "07C1E00285F6894C247C894424180F8EE1F5FFFF896C24108B4424308B6C247C"
    . "8B9C24A000000085DB7E5F8B8C24880000008B5C2414039C24A800000001C103"
    . "4424188944241C0384248800000089C70FB651020FB641010FB6316BC04B6BD2"
    . "2601C289F0C1E00429F001D039C50F970383C10483C30139F975D58BBC24A000"
    . "0000017C24148B44241C8344241001034424208B74241039B424A40000007580"
    . "E950F5FFFFC744240800000000E9B9F3FFFFC744242C00000000E997F7FFFF90"
    x64:=""
    . "4157415641554154555756534881EC88000000488BBC24F0000000488BB42430"
    . "01000083F90589542468448944240844898C24E8000000488B9C243801000048"
    . "8BAC24400100000F84300900008B8424580100004531ED4531E485C00F8EDC00"
    . "0000448974240C448BB4245001000031D231C04889BC24F00000004889B42430"
    . "0100004531FF4531ED4531E4C704240000000089D789C6660F1F840000000000"
    . "4585F67E6548631424478D1C3E4489F848039424480100004189F8EB1F0F1F00"
    . "83C0014D63D54183C0044183C5014883C2014139C346894C9500742A83F90345"
    . "89C1440F45C8803A3175D583C0014D63D44183C0044183C4014883C2014139C3"
    . "46890C9375D64401342483C6014403BC242001000003BC24F800000039B42458"
    . "0100000F8577FFFFFF448B74240C488BBC24F0000000488BB4243001000031C0"
    . "4439A42460010000440F4DE04439AC2468010000440F4DE84539EC4589EF450F"
    . "4DFC83F9030F84270900008B8424F80000008B9424100100000FAF8424180100"
    . "008D04908B9424F8000000894424208B842420010000F7D885C98D0482890424"
    . "0F85C40300008B4C24684889C84189CB0FB6C441C1EB1089C20FB6C1450FB6DB"
    . "4189C28B84242801000085C00F8E370100008B842420010000448964242831C9"
    . "44896C24304889B42430010000448B6C2420448B6424088BB42420010000C1E0"
    . "0244897C24184889BC24F00000004889AC24400100004189CFC744240C000000"
    . "008944241089D748899C24380100004489D585F60F8E8A000000488B9C24F000"
    . "00004963C54531D24C8D4C030248635C240C48039C2430010000660F1F440000"
    . "450FB631410FB651FE410FB641FF29EA4489F14501DE4189D0418D9600040000"
    . "4429D929F80FAFD10FAFC00FAFD1C1E00B8D0402BAFE0500004429F2410FAFD0"
    . "410FAFD001D04139C4420F9304134983C2014983C1044439D67FA544036C2410"
    . "0174240C4183C70144032C244439BC24280100000F8558FFFFFF448B7C241844"
    . "8B642428448B6C2430488BBC24F0000000488BB42430010000488B9C24380100"
    . "00488BAC24400100008B8424200100002B842450010000C644245700C644244C"
    . "00C744246C00000000C744247800000000894424708B8424280100002B842458"
    . "010000894424408B8424E800000083E80183F8070F870606000083F803894424"
    . "480F8E010600008B4424788B4C246C8944246C894C24788B4C2470394C246C0F"
    . "8F350B00008B4424708B4C244848899C24380100004889AC24400100004489ED"
    . "4589E5C74424300000000089442474418D4424FF4C8BA42440010000488D4483"
    . "044889F3488BB42438010000488944246089C883E0018944245089C883E00389"
    . "44247C4489F04589FE4189C78B4424788B4C244039C80F8F3E010000837C247C"
    . "018B54246C0F4F542474894C2428890424895424448B44245085C08B4424280F"
    . "440424837C2448038944240C0F8FCF020000807C244C008B442444894424100F"
    . "85D7020000807C2457000F85700300008B4C24100FAF8C2420010000034C240C"
    . "4585F67E59448B942468010000448B8C246001000031C0660F1F840000000000"
    . "4139C589C27E184189C84403048642803C0300750A4183E9010F888500000039"
    . "D57E1289CA41031484803C130074064183EA01786F4883C0014139C67FC24585"
    . "ED741E4C8B4424604889F00F1F44000089CA03104883C0044C39C0C604130075"
    . "EF8B4C24308B54240C039424100100004C8B94247001000089C801C048984189"
    . "14828B54241003942418010000418954820489C883C0013B8424780100008944"
    . "24307D2E83042401836C2428018B0424394424400F8DDBFEFFFF8344246C0183"
    . "6C2474018B44246C394424700F8D9AFEFFFF8B4424304881C4880000005B5E5F"
    . "5D415C415D415E415FC383F9010F847108000083F9020F84370500008B542468"
    . "448B542408C744241000000000C74424180000000089D0440FB6C2C1E810440F"
    . "B6C84889D00FB6CC4489D04589CBC1E810894C240C0FB6D04C89D00FB6C44129"
    . "D34401CA89C18B44240C29C8034C240C89442430410FB6C24589C24129C24401"
    . "C0448B8424280100008944240C8B842420010000C1E0024585C0894424280F8E"
    . "05FDFFFF448974243C44896C244448899C2438010000448B742420448B6C2430"
    . "8B9C242001000044897C243844896424404189CF4889AC24400100004189D444"
    . "89D585DB7E784C635424184963C631D2488D4407024901F2EB37660F1F440000"
    . "4539C47C3E4139CD7F394139CF7C344439CD410F9EC044394C240C0F9DC14883"
    . "C0044421C141880C124883C20139D37E24440FB6000FB648FF440FB648FE4539"
    . "C37EBD31C94883C00441880C124883C20139D37FDC4403742428015C24188344"
    . "241001440334248B442410398424280100000F856AFFFFFF448B7C2438448B74"
    . "243C448B642440448B6C2444488B9C2438010000488BAC2440010000E908FCFF"
    . "FF8B44240C807C244C00894424108B4424448944240C0F8429FDFFFF8B442410"
    . "8B4C240C0FAF8424F80000004585F6448D14880F8EA8FDFFFF448B8C24600100"
    . "004531C04989DB660F1F840000000000428B1486438B1C844401D289D98D4202"
    . "C1E9100FB6C948980FB6040729C88D4A014863D20FAFC00FB614174863C90FB6"
    . "0C0F4439F87F1A0FB6C729C10FAFC94439F97F0D0FB6C329C20FAFD24439FA7E"
    . "0A4183E9010F88950100004983C0014539C67F9C895C24684C89DBE921FDFFFF"
    . "8B4424108B4C240C0FAF8424F80000008D048889C1034424684585F68D500248"
    . "63D2440FB614178D500148980FB604074863D20FB614170F8EE4FCFFFF448B9C"
    . "246801000048895C24584531C948897424184C8964242089CB89C64189D44489"
    . "5C243C448B9C246001000044895C24384539CD4589C87E6E488B442418428B14"
    . "8801DA8D42024898440FB63C078D42014863D20FB6141748980FB604074589FB"
    . "4501D7418D8F000400004529D329F2410FAFCB4429E00FAFC0410FAFCB41BBFE"
    . "050000C1E00B4529FB440FAFDA01C8410FAFD301C239542408730B836C243801"
    . "0F88A60000004439C57E6A488B442420428B148801DA8D42024898440FB63C07"
    . "8D42014863D20FB6141748980FB604074589F84501D7418D8F000400004529D0"
    . "29F2410FAFC84429E00FAFC0410FAFC841B8FE050000C1E00B4529F8440FAFC2"
    . "01C8410FAFD001C2395424087207836C243C0178374983C1014539CE0F8F0EFF"
    . "FFFF488B5C2458488B7424184C8B642420E9ABFBFFFF662E0F1F840000000000"
    . "895C24684C89DBE9D8FBFFFF488B5C2458488B7424184C8B642420E9C4FBFFFF"
    . "C7442448000000008B4424408B4C247089442470894C2440E9FAF9FFFF8B4424"
    . "68448B7C24084531C04531DB4531C94189C6440FAFF0488B8424480100000FB6"
    . "104C8D5001EB2B4489CA450FB7C94D63C3C1EA100FAF9424F8000000428D148A"
    . "4531C942891483410FB6124189C04983C2010FBEC285C074418D50D083FA0977"
    . "09438D1489448D4C50D083F82F7408410FB61284D275D74489C083F0014585C0"
    . "74A54963D34189C04183C30144894C95004531C9410FB612EBB444894C246883"
    . "F9058B8424200100000F9444244C83F9030F94442457038424100100002B8424"
    . "50010000894424708B842418010000038424280100002B842458010000894424"
    . "408B842418010000C7842418010000000000008944246C8B842410010000C784"
    . "24100100000000000089442478E9B5F8FFFF8B44246831D2F7B424500100000F"
    . "AF8424F80000008D049089442468E96CFFFFFF8B8424200100008B9424180100"
    . "000FAF842428010000448D5AFF48984801F0488904248B842420010000038424"
    . "100100008944240C8B842418010000038424280100004439D80F8C610100008B"
    . "94241001000083C001448B9424F8000000894424282B8C241001000044896424"
    . "48448BA4240001000083EA01C74424180000000044897C24408D049500000000"
    . "895424384489742444450FAFD344896C244C48899C2438010000894424204898"
    . "48894424308B44240C448954241001C1448D5001894C243C8B4424383944240C"
    . "0F8CA40000008B4C24108B5424204589DE488B5C24304C6344241841C1EE1F4C"
    . "03042401CA4C63F94863D24C8D0C174829D3EB514139C47E554584F675504439"
    . "9C24080100007E46410FB64902410FB6510183C0014983C0016BD24B6BC92601"
    . "D14A8D140B4983C104460FB62C3A4489EAC1E2044429EA01D1C1F907418848FF"
    . "4139C2741D89C2C1EA1F84D274A683C00141C600004983C1044983C0014139C2"
    . "75E38B5C243C015C24184183C3018B9C24F8000000015C241044395C24280F85"
    . "34FFFFFF448B7C2440448B742444448B642448448B6C244C488B9C2438010000"
    . "8B842420010000448B94242801000083C0024585D20F8E8EF6FFFF488B0C2448"
    . "9844897C24384889442410448B7C246848899C2438010000C704240100000048"
    . "8D440101C744240C00000000448974243C4889C18B8424280100004889CB83C0"
    . "01894424184863842420010000488D500348F7D048894424288B842420010000"
    . "48895424208B54240883E8014883C0014889442430448B8C24200100004585C9"
    . "0F8EAD000000488B44242048634C240C4C8D0C18488B4424284801F14C8D0418"
    . "488B4424304C8D34184889D80F1F40000FB610440FB650FF41BB010000004401"
    . "FA4439D2724A440FB650014439D27240450FB650FF4439D27236450FB651FF44"
    . "39D2722C450FB650FE4439D27222450FB6104439D27219450FB651FE4439D272"
    . "0F450FB6114439D2410F92C30F1F40004883C0014488194983C1014883C10149"
    . "83C0014C39F075888B8C2420010000014C240C8304240148035C24108B042439"
    . "4424180F852CFFFFFF448B7C2438448B74243C89542408488B9C2438010000E9"
    . "25F5FFFF8B8424200100008B5424684531DBC744240C00000000C1E00283C201"
    . "894424108B842428010000C1E2078954246885C00F8EEFF4FFFF44897C241848"
    . "899C2438010000448B7C2468448B9424200100008B5C242044897424284585D2"
    . "7E504C6374240C4863C34531C0488D4C07024901F60FB6110FB641FF440FB649"
    . "FE6BC04B6BD22601C24489C8C1E0044429C801D04139C7430F9704064983C001"
    . "4883C1044539C27FCC035C2410440154240C4183C301031C2444399C24280100"
    . "00759A448B7C2418448B742428488B9C2438010000E94FF4FFFFC74424300000"
    . "0000E98BF6FFFF909090909090909090"
    this.MCode(MyFunc, A_PtrSize=8 ? x64:x32)
  }
  num:=info.Length(), j:=info[index]
  , text:=j[1], w:=j[2], h:=j[3]
  , e1:=(!j[12] ? Floor(j[4]*err1) : j[6])
  , e0:=(!j[12] ? Floor(j[5]*err0) : j[7])
  , mode:=j[8], color:=j[9], n:=j[10], comment:=j[11]
  , sx:=ini.sx, sy:=ini.sy, sw:=ini.sw, sh:=ini.sh
  if (JoinText and index>1)
  {
    x:=ini.x, y:=ini.y, sw:=Min(x+offsetX+w,sx+sw), sx:=x, sw-=sx
    , sh:=Min(y+offsetY+h,sy+sh), sy:=Max(y-offsetY,sy), sh-=sy
  }
  ok:=!bits.Scan0 ? 0 : DllCall(&MyFunc
    , "int",mode, "uint",color, "uint",n, "int",dir
    , "Ptr",bits.Scan0, "int",bits.Stride
    , "int",ini.zw, "int",ini.zh
    , "int",sx, "int",sy, "int",sw, "int",sh
    , "Ptr",&ss, "Ptr",&s1, "Ptr",&s0
    , "AStr",text, "int",w, "int",h, "int",e1, "int",e0
    , "Ptr",&allpos, "int",allpos_max)
  pos:=[]
  Loop % ok
    pos[A_Index]:=NumGet(allpos, 8*A_Index-8, "uint")
      | NumGet(allpos, 8*A_Index-4, "uint")<<32
  Loop % ok
  {
    x:=pos[A_Index], y:=x>>32, x:=x&0xFFFFFFFF
    if (!JoinText)
    {
      x1:=x+ini.zx, y1:=y+ini.zy
      , arr.Push( {1:x1, 2:y1, 3:w, 4:h
      , x:x1+w//2, y:y1+h//2, id:comment} )
    }
    else if (index=1)
    {
      ini.x:=x+w, ini.y:=y, ini.minY:=y, ini.maxY:=y+h
      Loop % num-1
        if !this.PicFind(arr, ini, info, A_Index+1, err1, err0
        , FindAll, JoinText, offsetX, offsetY, 5
        , bits, ss, s1, s0, allpos, 1)
          Continue, 2
      x1:=x+ini.zx, y1:=ini.minY+ini.zy
      , w1:=ini.x-x, h1:=ini.maxY-ini.minY
      , arr.Push( {1:x1, 2:y1, 3:w1, 4:h1
      , x:x1+w1//2, y:y1+h1//2, id:ini.comment} )
    }
    else
    {
      ini.x:=x+w, ini.y:=y
      , (y<ini.minY && ini.minY:=y)
      , (y+h>ini.maxY && ini.maxY:=y+h)
      return 1
    }
    if (!FindAll and arr.Length())
      return
  }
}

GetBitsFromScreen(ByRef x, ByRef y, ByRef w, ByRef h
  , ScreenShot:=1, ByRef zx:="", ByRef zy:=""
  , ByRef zw:="", ByRef zh:="")
{
  local
  bits:=this.bits
  if (!ScreenShot)
  {
    zx:=bits.zx, zy:=bits.zy, zw:=bits.zw, zh:=bits.zh
    if IsByRef(x)
      w:=Min(x+w,zx+zw), x:=Max(x,zx), w-=x
      , h:=Min(y+h,zy+zh), y:=Max(y,zy), h-=y
    return bits
  }
  bch:=A_BatchLines, cri:=A_IsCritical
  Critical
  if (id:=this.BindWindow(0,0,1))
  {
    WinGet, id, ID, ahk_id %id%
    WinGetPos, zx, zy, zw, zh, ahk_id %id%
  }
  if (!id)
  {
    SysGet, zx, 76
    SysGet, zy, 77
    SysGet, zw, 78
    SysGet, zh, 79
  }
  bits.zx:=zx, bits.zy:=zy, bits.zw:=zw, bits.zh:=zh
  , w:=Min(x+w,zx+zw), x:=Max(x,zx), w-=x
  , h:=Min(y+h,zy+zh), y:=Max(y,zy), h-=y
  if (zw>bits.oldzw or zh>bits.oldzh or !bits.hBM)
  {
    hBM:=bits.hBM
    , bits.hBM:=this.CreateDIBSection(zw, zh, bpp:=32, ppvBits)
    , bits.Scan0:=(!bits.hBM ? 0:ppvBits)
    , bits.Stride:=((zw*bpp+31)//32)*4
    , bits.oldzw:=zw, bits.oldzh:=zh
    , DllCall("DeleteObject", "Ptr",hBM)
  }
  if (w<1 or h<1 or !bits.hBM)
  {
    Critical, %cri%
    SetBatchLines, %bch%
    return bits
  }
  if IsFunc(k:="GetBitsFromScreen2")
    and %k%(bits, x-zx, y-zy, w, h)
  {
    zx:=bits.zx, zy:=bits.zy, zw:=bits.zw, zh:=bits.zh
    Critical, %cri%
    SetBatchLines, %bch%
    return bits
  }
  mDC:=DllCall("CreateCompatibleDC", "Ptr",0, "Ptr")
  oBM:=DllCall("SelectObject", "Ptr",mDC, "Ptr",bits.hBM, "Ptr")
  if (id)
  {
    if (mode:=this.BindWindow(0,0,0,1))<2
    {
      hDC2:=DllCall("GetDCEx", "Ptr",id, "Ptr",0, "int",3, "Ptr")
      DllCall("BitBlt","Ptr",mDC,"int",x-zx,"int",y-zy,"int",w,"int",h
        , "Ptr",hDC2, "int",x-zx, "int",y-zy, "uint",0xCC0020|0x40000000)
      DllCall("ReleaseDC", "Ptr",id, "Ptr",hDC2)
    }
    else
    {
      hBM2:=this.CreateDIBSection(zw, zh)
      mDC2:=DllCall("CreateCompatibleDC", "Ptr",0, "Ptr")
      oBM2:=DllCall("SelectObject", "Ptr",mDC2, "Ptr",hBM2, "Ptr")
      DllCall("PrintWindow", "Ptr",id, "Ptr",mDC2, "uint",(mode>3)*3)
      DllCall("BitBlt","Ptr",mDC,"int",x-zx,"int",y-zy,"int",w,"int",h
        , "Ptr",mDC2, "int",x-zx, "int",y-zy, "uint",0xCC0020|0x40000000)
      DllCall("SelectObject", "Ptr",mDC2, "Ptr",oBM2)
      DllCall("DeleteDC", "Ptr",mDC2)
      DllCall("DeleteObject", "Ptr",hBM2)
    }
  }
  else
  {
    win:=DllCall("GetDesktopWindow", "Ptr")
    hDC:=DllCall("GetWindowDC", "Ptr",win, "Ptr")
    DllCall("BitBlt","Ptr",mDC,"int",x-zx,"int",y-zy,"int",w,"int",h
      , "Ptr",hDC, "int",x, "int",y, "uint",0xCC0020|0x40000000)
    DllCall("ReleaseDC", "Ptr",win, "Ptr",hDC)
  }
  if this.CaptureCursor(0,0,0,0,0,1)
    this.CaptureCursor(mDC, zx, zy, zw, zh)
  DllCall("SelectObject", "Ptr",mDC, "Ptr",oBM)
  DllCall("DeleteDC", "Ptr",mDC)
  Critical, %cri%
  SetBatchLines, %bch%
  return bits
}

CreateDIBSection(w, h, bpp:=32, ByRef ppvBits:=0, ByRef bi:="")
{
  VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
  , NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
  , NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
  return DllCall("CreateDIBSection", "Ptr",0, "Ptr",&bi
    , "int",0, "Ptr*",ppvBits:=0, "Ptr",0, "int",0, "Ptr")
}

PicInfo(text)
{
  local
  static info:=[]
  if !InStr(text,"$")
    return
  key:=(r:=StrLen(text))<1000 ? text
    : DllCall("ntdll\RtlComputeCrc32", "uint",0
    , "Ptr",&text, "uint",r*(1+!!A_IsUnicode), "uint")
  if (info[key])
    return info[key]
  v:=text, comment:="", seterr:=e1:=e0:=0
  ; You Can Add Comment Text within The <>
  if RegExMatch(v,"<([^>\n]*)>",r)
    v:=StrReplace(v,r), comment:=Trim(r1)
  ; You can Add two fault-tolerant in the [], separated by commas
  if RegExMatch(v,"\[([^\]\n]*)]",r)
  {
    v:=StrReplace(v,r), r:=StrSplit(r1, ",")
    , seterr:=1, e1:=r[1], e0:=r[2]
  }
  color:=StrSplit(v,"$")[1], v:=Trim(SubStr(v,InStr(v,"$")+1))
  mode:=InStr(color,"##") ? 5
    : InStr(color,"-") ? 4 : InStr(color,"#") ? 3
    : InStr(color,"**") ? 2 : InStr(color,"*") ? 1 : 0
  color:=RegExReplace(color, "[*#\s]")
  if (mode=5)
  {
    if (v~="[^\s\w/]") and FileExist(v)  ; ImageSearch
    {
      if !(hBM:=LoadPicture(v))
        return
      this.GetBitmapWH(hBM, w, h)
      if (w<1 or h<1)
        return
      hBM2:=this.CreateDIBSection(w, h, 32, Scan0)
      this.CopyHBM(hBM2, 0, 0, hBM, 0, 0, w, h)
      DllCall("DeleteObject", "Ptr",hBM)
      if (!Scan0)
        return
      c1:=NumGet(Scan0+0,"uint")&0xFFFFFF
      c2:=NumGet(Scan0+(w-1)*4,"uint")&0xFFFFFF
      c3:=NumGet(Scan0+(w*h-w)*4,"uint")&0xFFFFFF
      c4:=NumGet(Scan0+(w*h-1)*4,"uint")&0xFFFFFF
      if (c1!=c2 or c1!=c3 or c1!=c4)
        c1:=-1
      VarSetCapacity(v, w*h*18*(1+!!A_IsUnicode)), i:=-4, n:=0
      SetFormat, IntegerFast, d
      Loop %h%
      {
        y:=A_Index-1
        Loop %w%
          if (c:=NumGet(Scan0+(i+=4),"uint")&0xFFFFFF)!=c1
            v.=((A_Index-1)|y<<16) "/" c "/", n++
      }
      DllCall("DeleteObject", "Ptr",hBM2)
    }
    else
    {
      v:=Trim(StrReplace(RegExReplace(v,"\s"),",","/"),"/")
      r:=StrSplit(v,"/"), n:=r.Length()//3
      if (!n)
        return
      VarSetCapacity(v, n*18*(1+!!A_IsUnicode))
      x1:=x2:=r[1], y1:=y2:=r[2]
      SetFormat, IntegerFast, d
      Loop % n + (i:=-2)*0
        x:=r[i+=3], y:=r[i+1]
        , (x<x1 && x1:=x), (x>x2 && x2:=x)
        , (y<y1 && y1:=y), (y>y2 && y2:=y)
      Loop % n + (i:=-2)*0
        v.=(r[i+=3]-x1)|(r[i+1]-y1)<<16 . "/"
        . Floor("0x" StrReplace(r[i+2],"0x"))&0xFFFFFF . "/"
      w:=x2-x1+1, h:=y2-y1+1
    }
    len1:=n, len0:=0
  }
  else
  {
    r:=StrSplit(v,"."), w:=r[1]
    , v:=this.base64tobit(r[2]), h:=StrLen(v)//w
    if (w<1 or h<1 or StrLen(v)!=w*h)
      return
    if (mode=4)
    {
      r:=StrSplit(StrReplace(color,"0x"),"-")
      , color:=Round("0x" r[1]), n:=Round("0x" r[2])
    }
    else
    {
      r:=StrSplit(color,"@")
      , color:=r[1], n:=Round(r[2],2)+(!r[2])
      , n:=Floor(512*9*255*255*(1-n)*(1-n))
    }
    StrReplace(v,"1","",len1), len0:=StrLen(v)-len1
  }
  e1:=Floor(len1*e1), e0:=Floor(len0*e0)
  return info[key]:=[v, w, h, len1, len0, e1, e0
    , mode, color, n, comment, seterr]
}

GetBitmapWH(hbm, ByRef w, ByRef h)
{
  local
  VarSetCapacity(bm, size:=(A_PtrSize=8 ? 32:24), 0)
  r:=DllCall("GetObject", "Ptr",hbm, "int",size, "Ptr",&bm)
  w:=NumGet(bm,4,"int"), h:=Abs(NumGet(bm,8,"int"))
  return r
}

CopyHBM(hBM1, x1, y1, hBM2, x2, y2, w2, h2)
{
  local
  mDC1:=DllCall("CreateCompatibleDC", "Ptr",0, "Ptr")
  oBM1:=DllCall("SelectObject", "Ptr",mDC1, "Ptr",hBM1, "Ptr")
  mDC2:=DllCall("CreateCompatibleDC", "Ptr",0, "Ptr")
  oBM2:=DllCall("SelectObject", "Ptr",mDC2, "Ptr",hBM2, "Ptr")
  DllCall("BitBlt", "Ptr",mDC1
    , "int",x1, "int",y1, "int",w2, "int",h2, "Ptr",mDC2
    , "int",x2, "int",y2, "uint",0xCC0020)
  DllCall("SelectObject", "Ptr",mDC2, "Ptr",oBM2)
  DllCall("DeleteDC", "Ptr",mDC2)
  DllCall("SelectObject", "Ptr",mDC1, "Ptr",oBM1)
  DllCall("DeleteDC", "Ptr",mDC1)
}

CopyBits(Scan01,Stride1,x1,y1,Scan02,Stride2,x2,y2,w2,h2,Reverse:=0)
{
  local
    p1:=Scan01+(y1-1)*Stride1+x1*4
  , p2:=Scan02+(y2-1)*Stride2+x2*4, w2*=4
  if (Reverse)
    p2+=(h2+1)*Stride2, Stride2:=-Stride2
  Loop % h2
    DllCall("RtlMoveMemory","Ptr",p1+=Stride1,"Ptr",p2+=Stride2,"Ptr",w2)
}

; Bind the window so that it can find images when obscured
; by other windows, it's equivalent to always being
; at the front desk. Unbind Window using FindText().BindWindow(0)

BindWindow(bind_id:=0, bind_mode:=0, get_id:=0, get_mode:=0)
{
  local
  bind:=this.bind
  if (get_id)
    return bind.id
  if (get_mode)
    return bind.mode
  if (bind_id)
  {
    bind.id:=bind_id, bind.mode:=bind_mode, bind.oldStyle:=0
    if (bind_mode & 1)
    {
      WinGet, oldStyle, ExStyle, ahk_id %bind_id%
      bind.oldStyle:=oldStyle
      WinSet, Transparent, 255, ahk_id %bind_id%
      Loop 30
      {
        Sleep, 100
        WinGet, i, Transparent, ahk_id %bind_id%
      }
      Until (i=255)
    }
  }
  else
  {
    bind_id:=bind.id
    if (bind.mode & 1)
      WinSet, ExStyle, % bind.oldStyle, ahk_id %bind_id%
    bind.id:=0, bind.mode:=0, bind.oldStyle:=0
  }
}

; Use FindText().CaptureCursor(1) to Capture Cursor
; Use FindText().CaptureCursor(0) to Cancel Capture Cursor

CaptureCursor(hDC:=0, zx:=0, zy:=0, zw:=0, zh:=0, get_cursor:=0)
{
  local
  if (get_cursor)
    return this.Cursor
  if (hDC=1 or hDC=0) and (zw=0)
  {
    this.Cursor:=hDC
    return
  }
  VarSetCapacity(mi, 40, 0), NumPut(16+A_PtrSize, mi, "int")
  DllCall("GetCursorInfo", "Ptr",&mi)
  bShow   := NumGet(mi, 4, "int")
  hCursor := NumGet(mi, 8, "Ptr")
  x := NumGet(mi, 8+A_PtrSize, "int")
  y := NumGet(mi, 12+A_PtrSize, "int")
  if (!bShow) or (x<zx or y<zy or x>=zx+zw or y>=zy+zh)
    return
  VarSetCapacity(ni, 40, 0)
  DllCall("GetIconInfo", "Ptr",hCursor, "Ptr",&ni)
  xCenter  := NumGet(ni, 4, "int")
  yCenter  := NumGet(ni, 8, "int")
  hBMMask  := NumGet(ni, (A_PtrSize=8?16:12), "Ptr")
  hBMColor := NumGet(ni, (A_PtrSize=8?24:16), "Ptr")
  DllCall("DrawIconEx", "Ptr",hDC
    , "int",x-xCenter-zx, "int",y-yCenter-zy, "Ptr",hCursor
    , "int",0, "int",0, "int",0, "int",0, "int",3)
  DllCall("DeleteObject", "Ptr",hBMMask)
  DllCall("DeleteObject", "Ptr",hBMColor)
}

MCode(ByRef code, hex)
{
  local
  SetBatchLines, % (bch:=A_BatchLines)?"-1":"-1"
  VarSetCapacity(code, len:=StrLen(hex)//2)
  Loop % len
    NumPut("0x" SubStr(hex,2*A_Index-1,2),code,A_Index-1,"uchar")
  DllCall("VirtualProtect","Ptr",&code,"Ptr",len,"uint",0x40,"Ptr*",0)
  SetBatchLines, %bch%
}

base64tobit(s)
{
  local
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  Loop Parse, Chars
  {
    s:=RegExReplace(s, "[" A_LoopField "]"
    , StrReplace( ((i:=A_Index-1)>>5&1) . (i>>4&1)
    . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1), "0x"))
  }
  return RegExReplace(RegExReplace(s,"[^01]+"),"10*$")
}

bit2base64(s)
{
  local
  s:=RegExReplace(s,"[^01]+")
  s.=SubStr("100000",1,6-Mod(StrLen(s),6))
  s:=RegExReplace(s,".{6}","|$0")
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  Loop Parse, Chars
  {
    s:=StrReplace(s, StrReplace("|" . ((i:=A_Index-1)>>5&1)
    . (i>>4&1) . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    , "0x"), A_LoopField)
  }
  return s
}

xywh2xywh(x1,y1,w1,h1, ByRef x, ByRef y, ByRef w, ByRef h
  , ByRef zx:="", ByRef zy:="", ByRef zw:="", ByRef zh:="")
{
  SysGet, zx, 76
  SysGet, zy, 77
  SysGet, zw, 78
  SysGet, zh, 79
  w:=Min(x1+w1,zx+zw), x:=Max(x1,zx), w-=x
  , h:=Min(y1+h1,zy+zh), y:=Max(y1,zy), h-=y
}

ASCII(s)
{
  local
  if RegExMatch(s,"\$(\d+)\.([\w+/]+)",r)
  {
    s:=RegExReplace(this.base64tobit(r2),".{" r1 "}","$0`n")
    s:=StrReplace(StrReplace(s,"0","_"),"1","0")
  }
  else s:=""
  return s
}

; You can put the text library at the beginning of the script,
; and Use FindText().PicLib(Text,1) to add the text library to PicLib()'s Lib,
; Use FindText().PicLib("comment1|comment2|...") to get text images from Lib

PicLib(comments, add_to_Lib:=0, index:=1)
{
  local
  Lib:=this.Lib, (!Lib.HasKey(index) && Lib[index]:=[]), Lib:=Lib[index]
  if (add_to_Lib)
  {
    re:="<([^>\n]*)>[^$\n]+\$\d+\.[\w+/]+"
    Loop Parse, comments, |
      if RegExMatch(A_LoopField,re,r)
      {
        s1:=Trim(r1), s2:=""
        Loop Parse, s1
          s2.="_" . Format("{:d}",Ord(A_LoopField))
        Lib[s2]:=r
      }
    Lib[""]:=""
  }
  else
  {
    Text:=""
    Loop Parse, comments, |
    {
      s1:=Trim(A_LoopField), s2:=""
      Loop Parse, s1
        s2.="_" . Format("{:d}",Ord(A_LoopField))
      Text.="|" . Lib[s2]
    }
    return Text
  }
}

; Decompose a string into individual characters and get their data

PicN(Number, index:=1)
{
  return this.PicLib(RegExReplace(Number,".","|$0"), 0, index)
}

; Use FindText().PicX(Text) to automatically cut into multiple characters
; Can't be used in ColorPos mode, because it can cause position errors

PicX(Text)
{
  local
  if !RegExMatch(Text,"(<[^$\n]+)\$(\d+)\.([\w+/]+)",r)
    return Text
  v:=this.base64tobit(r3), Text:=""
  c:=StrLen(StrReplace(v,"0"))<=StrLen(v)//2 ? "1":"0"
  txt:=RegExReplace(v,".{" r2 "}","$0`n")
  While InStr(txt,c)
  {
    While !(txt~="m`n)^" c)
      txt:=RegExReplace(txt,"m`n)^.")
    i:=0
    While (txt~="m`n)^.{" i "}" c)
      i:=Format("{:d}",i+1)
    v:=RegExReplace(txt,"m`n)^(.{" i "}).*","$1")
    txt:=RegExReplace(txt,"m`n)^.{" i "}")
    if (v!="")
      Text.="|" r1 "$" i "." this.bit2base64(v)
  }
  return Text
}

; Screenshot and retained as the last screenshot.

ScreenShot(x1:=0, y1:=0, x2:=0, y2:=0)
{
  this.FindText("", "", x1, y1, x2, y2)
}

; Get the RGB color of a point from the last screenshot.
; If the point to get the color is beyond the range of
; Screen, it will return White color (0xFFFFFF).

GetColor(x, y, fmt:=1)
{
  local
  bits:=this.GetBitsFromScreen(0,0,0,0,0,zx,zy,zw,zh)
  , c:=(x<zx or x>=zx+zw or y<zy or y>=zy+zh or !bits.Scan0)
  ? 0xFFFFFF : NumGet(bits.Scan0+(y-zy)*bits.Stride+(x-zx)*4,"uint")
  return (fmt ? Format("0x{:06X}",c&0xFFFFFF) : c)
}

; Set the RGB color of a point in the last screenshot

SetColor(x, y, color:=0x000000)
{
  local
  bits:=this.GetBitsFromScreen(0,0,0,0,0,zx,zy,zw,zh)
  if !(x<zx or x>=zx+zw or y<zy or y>=zy+zh or !bits.Scan0)
    NumPut(color,bits.Scan0+(y-zy)*bits.Stride+(x-zx)*4,"uint")
}

; Identify a line of text or verification code
; based on the result returned by FindText().
; offsetX is the maximum interval between two texts,
; if it exceeds, a "*" sign will be inserted.
; offsetY is the maximum height difference between two texts.
; overlapW is used to set the width of the overlap.
; Return Association array {text:Text, x:X, y:Y, w:W, h:H}

Ocr(ok, offsetX:=20, offsetY:=20, overlapW:=0)
{
  local
  ocr_Text:=ocr_X:=ocr_Y:=min_X:=dx:=""
  For k,v in ok
    x:=v[1]
    , min_X:=(A_Index=1 or x<min_X ? x : min_X)
    , max_X:=(A_Index=1 or x>max_X ? x : max_X)
  While (min_X!="" and min_X<=max_X)
  {
    LeftX:=""
    For k,v in ok
    {
      x:=v[1], y:=v[2]
      if (x<min_X) or Abs(y-ocr_Y)>offsetY
        Continue
      ; Get the leftmost X coordinates
      if (LeftX="" or x<LeftX)
        LeftX:=x, LeftY:=y, LeftW:=v[3], LeftH:=v[4], LeftOCR:=v.id
    }
    if (LeftX="")
      Break
    if (ocr_X="")
      ocr_X:=LeftX, min_Y:=LeftY, max_Y:=LeftY+LeftH
    ; If the interval exceeds the set value, add "*" to the result
    ocr_Text.=(ocr_Text!="" and LeftX>dx ? "*":"") . LeftOCR
    ; Update for next search
    min_X:=LeftX+LeftW-(overlapW>LeftW//2 ? LeftW//2:overlapW)
    , dx:=LeftX+LeftW+offsetX
    , ocr_Y:=LeftY, (LeftY<min_Y && min_Y:=LeftY)
    , (LeftY+LeftH>max_Y && max_Y:=LeftY+LeftH)
  }
  return {text:ocr_Text, x:ocr_X, y:min_Y
    , w: min_X-ocr_X, h: max_Y-min_Y}
}

; Sort the results returned by FindText() from left to right
; and top to bottom, ignore slight height difference

Sort(ok, dy:=10)
{
  local
  if !IsObject(ok)
    return ok
  ypos:=[]
  For k,v in ok
  {
    x:=v.x, y:=v.y, add:=1
    For k2,v2 in ypos
      if Abs(y-v2)<=dy
      {
        y:=v2, add:=0
        Break
      }
    if (add)
      ypos.Push(y)
    n:=(y*150000+x) "." k, s:=A_Index=1 ? n : s "-" n
  }
  Sort, s, N D-
  ok2:=[]
  Loop Parse, s, -
    ok2.Push( ok[(StrSplit(A_LoopField,".")[2])] )
  return ok2
}

; Reordering according to the nearest distance

Sort2(ok, px, py)
{
  local
  if !IsObject(ok)
    return ok
  For k,v in ok
    n:=((v.x-px)**2+(v.y-py)**2) "." k, s:=A_Index=1 ? n : s "-" n
  Sort, s, N D-
  ok2:=[]
  Loop Parse, s, -
    ok2.Push( ok[(StrSplit(A_LoopField,".")[2])] )
  return ok2
}

; Prompt mouse position in remote assistance

MouseTip(x:="", y:="", w:=10, h:=10, d:=4)
{
  local
  if (x="")
  {
    VarSetCapacity(pt,16,0), DllCall("GetCursorPos","ptr",&pt)
    x:=NumGet(pt,0,"uint"), y:=NumGet(pt,4,"uint")
  }
  x:=Round(x-w-d), y:=Round(y-h-d), w:=(2*w+1)+2*d, h:=(2*h+1)+2*d
  ;-------------------------
  Gui, _MouseTip_: +AlwaysOnTop -Caption +ToolWindow +Hwndmyid -DPIScale
  Gui, _MouseTip_: Show, Hide w%w% h%h%
  ;-------------------------
  DetectHiddenWindows, % (dhw:=A_DetectHiddenWindows)?"On":"On"
  i:=w-d, j:=h-d
  s:="0-0 " (w "-0 ") (w "-" h) (" 0-" h) " 0-0  "
    . (d "-" d) " " (i "-" d) " " (i "-" j) " " (d "-" j) " " (d "-" d)
  WinSet, Region, %s%, ahk_id %myid%
  DetectHiddenWindows, %dhw%
  ;-------------------------
  Gui, _MouseTip_: Show, NA x%x% y%y%
  Loop 4
  {
    Gui, _MouseTip_: Color, % A_Index & 1 ? "Red" : "Blue"
    Sleep, 500
  }
  Gui, _MouseTip_: Destroy
}

; Quickly get the search data of screen image

GetTextFromScreen(x1, y1, x2, y2, Threshold:=""
  , ScreenShot:=1, ByRef rx:="", ByRef ry:="")
{
  local
  SetBatchLines, % (bch:=A_BatchLines)?"-1":"-1"
  x:=Min(x1,x2), y:=Min(y1,y2), w:=Abs(x2-x1)+1, h:=Abs(y2-y1)+1
  this.GetBitsFromScreen(x,y,w,h,ScreenShot,zx,zy,zw,zh)
  if (w<1 or h<1)
  {
    SetBatchLines, %bch%
    return
  }
  gs:=[], k:=0
  Loop %h%
  {
    j:=y+A_Index-1
    Loop %w%
      i:=x+A_Index-1, c:=this.GetColor(i,j,0)
      , gs[++k]:=(((c>>16)&0xFF)*38+((c>>8)&0xFF)*75+(c&0xFF)*15)>>7
  }
  if InStr(Threshold,"**")
  {
    Threshold:=StrReplace(Threshold,"*")
    if (Threshold="")
      Threshold:=50
    s:="", sw:=w, w-=2, h-=2, x++, y++
    Loop %h%
    {
      y1:=A_Index
      Loop %w%
        x1:=A_Index, i:=y1*sw+x1+1, j:=gs[i]+Threshold
        , s.=( gs[i-1]>j || gs[i+1]>j
        || gs[i-sw]>j || gs[i+sw]>j
        || gs[i-sw-1]>j || gs[i-sw+1]>j
        || gs[i+sw-1]>j || gs[i+sw+1]>j ) ? "1":"0"
    }
    Threshold:="**" Threshold
  }
  else
  {
    Threshold:=StrReplace(Threshold,"*")
    if (Threshold="")
    {
      pp:=[]
      Loop 256
        pp[A_Index-1]:=0
      Loop % w*h
        pp[gs[A_Index]]++
      IP0:=IS0:=0
      Loop 256
        k:=A_Index-1, IP0+=k*pp[k], IS0+=pp[k]
      Threshold:=Floor(IP0/IS0)
      Loop 20
      {
        LastThreshold:=Threshold
        IP1:=IS1:=0
        Loop % LastThreshold+1
          k:=A_Index-1, IP1+=k*pp[k], IS1+=pp[k]
        IP2:=IP0-IP1, IS2:=IS0-IS1
        if (IS1!=0 and IS2!=0)
          Threshold:=Floor((IP1/IS1+IP2/IS2)/2)
        if (Threshold=LastThreshold)
          Break
      }
    }
    s:=""
    Loop % w*h
      s.=gs[A_Index]<=Threshold ? "1":"0"
    Threshold:="*" Threshold
  }
  ;--------------------
  w:=Format("{:d}",w), CutUp:=CutDown:=0
  re1:="(^0{" w "}|^1{" w "})"
  re2:="(0{" w "}$|1{" w "}$)"
  While RegExMatch(s,re1)
    s:=RegExReplace(s,re1), CutUp++
  While RegExMatch(s,re2)
    s:=RegExReplace(s,re2), CutDown++
  rx:=x+w//2, ry:=y+CutUp+(h-CutUp-CutDown)//2
  s:="|<>" Threshold "$" w "." this.bit2base64(s)
  ;--------------------
  SetBatchLines, %bch%
  return s
}

; Quickly save screen image to BMP file for debugging

SavePic(file, x1:=0, y1:=0, x2:=0, y2:=0, ScreenShot:=1)
{
  local
  if (x1*x1+y1*y1+x2*x2+y2*y2<=0)
    n:=150000, x:=y:=-n, w:=h:=2*n
  else
    x:=Min(x1,x2), y:=Min(y1,y2), w:=Abs(x2-x1)+1, h:=Abs(y2-y1)+1
  bits:=this.GetBitsFromScreen(x,y,w,h,ScreenShot,zx,zy,zw,zh)
  if (w<1 or h<1 or !bits.hBM)
    return
  hBM:=this.CreateDIBSection(w, -h, bpp:=24, ppvBits, bi)
  this.CopyHBM(hBM, 0, 0, bits.hBM, x-zx, y-zy, w, h)
  size:=((w*bpp+31)//32)*4*h, NumPut(size, bi, 20, "uint")
  VarSetCapacity(bf, 14, 0), StrPut("BM", &bf, "CP0")
  NumPut(54+size, bf, 2, "uint"), NumPut(54, bf, 10, "uint")
  f:=FileOpen(file,"w"), f.RawWrite(bf,14), f.RawWrite(bi,40)
  , f.RawWrite(ppvBits+0, size), f.Close()
  DllCall("DeleteObject", "Ptr",hBM)
}

; Show the saved Picture file

ShowPic(file:="", show:=1
  , ByRef zx:="", ByRef zy:="", ByRef w:="", ByRef h:="")
{
  local
  Gui, FindText_Screen: Destroy
  if (file="") or !FileExist(file)
    return
  bits:=this.GetBitsFromScreen(0,0,0,0,1,zx,zy,zw,zh)
  hBM:=bits.hBM, hBM2:=LoadPicture(file)
  this.GetBitmapWH(hBM2, w, h)
  this.CopyHBM(hBM, 0, 0, hBM2, 0, 0, w, h)
  DllCall("DeleteObject", "Ptr",hBM2)
  if (!show)
    return
  ;-------------------
  mDC:=DllCall("CreateCompatibleDC", "Ptr",0, "Ptr")
  oBM:=DllCall("SelectObject", "Ptr",mDC, "Ptr",hBM, "Ptr")
  hBrush:=DllCall("CreateSolidBrush", "uint",0xFFFFFF, "Ptr")
  oBrush:=DllCall("SelectObject", "Ptr",mDC, "Ptr",hBrush, "Ptr")
  DllCall("BitBlt", "Ptr",mDC, "int",0, "int",0, "int",zw, "int",zh
    , "Ptr",mDC, "int",0, "int",0, "uint",0xC000CA) ; MERGECOPY
  DllCall("SelectObject", "Ptr",mDC, "Ptr",oBrush)
  DllCall("DeleteObject", "Ptr",hBrush)
  DllCall("SelectObject", "Ptr",mDC, "Ptr",oBM)
  DllCall("DeleteDC", "Ptr",mDC)
  ;-------------------
  Gui, FindText_Screen: +AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08000000
  Gui, FindText_Screen: Margin, 0, 0
  Gui, FindText_Screen: Add, Pic,, HBITMAP:*%hBM%
  Gui, FindText_Screen: Show, NA x%zx% y%zy% w%zw% h%zh%, Show Pic
}

; Running AHK code dynamically with new threads

Class Thread
{
  __New(args*)
  {
    this.pid:=this.Exec(args*)
  }
  __Delete()
  {
    Process, Close, % this.pid
  }
  Exec(s, Ahk:="", args:="")
  {
    local
    Ahk:=Ahk ? Ahk:A_IsCompiled ? A_ScriptDir "\AutoHotkey.exe":A_AhkPath
    s:="DllCall(""SetWindowText"",""Ptr"",A_ScriptHwnd,""Str"",""<AHK>"")`n"
      . StrReplace(s,"`r"), pid:=""
    Try
    {
      shell:=ComObjCreate("WScript.Shell")
      oExec:=shell.Exec("""" Ahk """ /f * " args)
      oExec.StdIn.Write(s)
      oExec.StdIn.Close(), pid:=oExec.ProcessID
    }
    Catch
    {
      f:=A_Temp "\~ahk.tmp"
      s:="`n FileDelete, " f "`n" s
      FileDelete, %f%
      FileAppend, %s%, %f%
      r:=this.Clear.Bind(this)
      SetTimer, %r%, -3000
      Run, "%Ahk%" /f "%f%" %args%,, UseErrorLevel, pid
    }
    return pid
  }
  Clear()
  {
    FileDelete, % A_Temp "\~ahk.tmp"
    SetTimer,, Off
  }
}

; FindText().QPC() Use the same as A_TickCount

QPC()
{
  static f:=0, c:=DllCall("QueryPerformanceFrequency", "Int*",f)
  return (!DllCall("QueryPerformanceCounter","Int64*",c))*0+(c/f)*1000
}

WindowToScreen(ByRef x, ByRef y, x1, y1, id:="")
{
  local
  WinGetPos, winx, winy,,, % id ? "ahk_id " id : "A"
  x:=x1+Floor(winx), y:=y1+Floor(winy)
}

ScreenToWindow(ByRef x, ByRef y, x1, y1, id:="")
{
  local
  this.WindowToScreen(dx,dy,0,0,id), x:=x1-dx, y:=y1-dy
}

ClientToScreen(ByRef x, ByRef y, x1, y1, id:="")
{
  local
  if (!id)
    WinGet, id, ID, A
  VarSetCapacity(pt,8,0), NumPut(0,pt,"int64")
  , DllCall("ClientToScreen", "Ptr",id, "Ptr",&pt)
  , x:=x1+NumGet(pt,"int"), y:=y1+NumGet(pt,4,"int")
}

ScreenToClient(ByRef x, ByRef y, x1, y1, id:="")
{
  local
  this.ClientToScreen(dx,dy,0,0,id), x:=x1-dx, y:=y1-dy
}

; It is not like FindText always use Screen Coordinates,
; But like built-in command ImageSearch using CoordMode Settings

ImageSearch(ByRef rx, ByRef ry, x1, y1, x2, y2, text
  , ScreenShot:=1, FindAll:=0)
{
  local
  dx:=dy:=0
  if (A_CoordModePixel="Window")
    this.WindowToScreen(dx,dy,0,0)
  else if (A_CoordModePixel="Client")
    this.ClientToScreen(dx,dy,0,0)
  if (ok:=this.FindText(x, y, x1+dx, y1+dy, x2+dx, y2+dy
    , 0, 0, text, ScreenShot, FindAll))
  {
    rx:=x-dx, ry:=y-dy, ErrorLevel:=0
    return 1
  }
  else
  {
    rx:=ry:="", ErrorLevel:=1
    return 0
  }
}

Click(x:="", y:="", other:="", ms:="")
{
  local
  bak:=A_CoordModeMouse
  CoordMode, Mouse, Screen
  MouseMove, x, y, 0
  Click, %x%, %y%, %other%
  CoordMode, Mouse, %bak%
  Sleep, (ms!="" ? ms : InStr(other,"R") ? 500 : 100)
}

ToolTip(s:="", x:="", y:="", num:=1, arg:="")
{
  local
  static ini:=[]
  f:= "ToolTip_" . Round(num)
  if (s="")
  {
    ini.Delete(f)
    Gui, %f%: Destroy
    return
  }
  ;-----------------
  r1:=A_CoordModeToolTip
  r2:=A_CoordModeMouse
  CoordMode, Mouse, Screen
  MouseGetPos, x1, y1
  CoordMode, Mouse, %r1%
  MouseGetPos, x2, y2
  CoordMode, Mouse, %r2%
  x:=Round(x="" ? x1+16 : x+x1-x2)
  y:=Round(y="" ? y1+16 : y+y1-y2)
  ;-----------------
  bgcolor:=arg.bgcolor ? arg.bgcolor : "FAFBFC"
  color:=arg.color ? arg.color : "Black"
  font:=arg.font ? arg.font : "Consolas"
  size:=arg.size ? arg.size : "8"
  bold:=arg.bold ? arg.bold : ""
  ;-----------------
  r:=bgcolor "|" color "|" font "|" size "|" bold "|" s
  if (ini[f]!=r)
  {
    ini[f]:=r
    Gui, %f%: Destroy
    Gui, %f%: +AlwaysOnTop -Caption +ToolWindow +Border
    Gui, %f%: Margin, 2, 2
    Gui, %f%: Color, %bgcolor%
    Gui, %f%: Font, c%color% s%size% %bold%, %font%
    Gui, %f%: Add, Text,, %s%
    Gui, %f%: Show, Hide, %f%
  }
  Gui, %f%: +AlwaysOnTop
  Gui, %f%: Show, NA x%x% y%y%
}


/***** C source code of machine code *****

int __attribute__((__stdcall__)) PicFind(
  int mode, unsigned int c, unsigned int n, int dir
  , unsigned char * Bmp, int Stride, int zw, int zh
  , int sx, int sy, int sw, int sh
  , char * ss, unsigned int * s1, unsigned int * s0
  , char * text, int w, int h, int err1, int err0
  , unsigned int * allpos, int allpos_max )
{
  int ok=0, o, i, j, k, v, r, g, b, rr, gg, bb;
  int x, y, x1, y1, x2, y2, len1, len0, e1, e0, max;
  int r_min, r_max, g_min, g_max, b_min, b_max, x3, y3;
  unsigned char * gs;
  //----------------------
  // MultiColor or PixelSearch or ImageSearch Mode
  if (mode==5)
  {
    max=n; v=c*c;
    for (i=0, k=0, c=0, o=0; (j=text[o++])!='\0';)
    {
      if (j>='0' && j<='9') c=c*10+(j-'0');
      if (j=='/' || text[o]=='\0')
      {
        if (k=!k)
          s1[i]=(c>>16)*Stride+(c&0xFFFF)*4;
        else
          s0[i++]=c;
        c=0;
      }
    }
    goto StartLookUp;
  }
  //----------------------
  // Generate Lookup Table
  o=0; len1=0; len0=0;
  for (y=0; y<h; y++)
  {
    for (x=0; x<w; x++)
    {
      i=(mode==3) ? y*Stride+x*4 : y*sw+x;
      if (text[o++]=='1')
        s1[len1++]=i;
      else
        s0[len0++]=i;
    }
  }
  if (err1>=len1) len1=0;
  if (err0>=len0) len0=0;
  max=(len1>len0) ? len1 : len0;
  //----------------------
  // Color Position Mode
  // only used to recognize multicolored Verification Code
  if (mode==3)
    { c=(c/w)*Stride+(c%w)*4; goto StartLookUp; }
  //----------------------
  // Generate Two Value Image
  o=sy*Stride+sx*4; j=Stride-sw*4; i=0;
  if (mode==0)  // Color Mode
  {
    rr=(c>>16)&0xFF; gg=(c>>8)&0xFF; bb=c&0xFF;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
      {
        r=Bmp[2+o]-rr; g=Bmp[1+o]-gg; b=Bmp[o]-bb; v=r+rr+rr;
        ss[i]=((1024+v)*r*r+2048*g*g+(1534-v)*b*b<=n) ? 1:0;
      }
  }
  else if (mode==1)  // Gray Threshold Mode
  {
    c=(c+1)<<7;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
        ss[i]=(Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15<c) ? 1:0;
  }
  else if (mode==2)  // Gray Difference Mode
  {
    gs=(unsigned char *)(ss+sw*sh);
    x2=sx+sw; y2=sy+sh;
    for (y=sy-1; y<=y2; y++)
    {
      for (x=sx-1; x<=x2; x++, i++)
        if (x<0 || x>=zw || y<0 || y>=zh)
          gs[i]=0;
        else
        {
          o=y*Stride+x*4;
          gs[i]=(Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15)>>7;
        }
    }
    k=sw+2; i=0;
    for (y=1; y<=sh; y++)
      for (x=1; x<=sw; x++, i++)
      {
        o=y*k+x; n=gs[o]+c;
        ss[i]=(gs[o-1]>n || gs[o+1]>n
          || gs[o-k]>n   || gs[o+k]>n
          || gs[o-k-1]>n || gs[o-k+1]>n
          || gs[o+k-1]>n || gs[o+k+1]>n) ? 1:0;
      }
  }
  else  // (mode==4) Color Difference Mode
  {
    r=(c>>16)&0xFF; g=(c>>8)&0xFF; b=c&0xFF;
    rr=(n>>16)&0xFF; gg=(n>>8)&0xFF; bb=n&0xFF;
    r_min=r-rr; g_min=g-gg; b_min=b-bb;
    r_max=r+rr; g_max=g+gg; b_max=b+bb;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
      {
        r=Bmp[2+o]; g=Bmp[1+o]; b=Bmp[o];
        ss[i]=(r>=r_min && r<=r_max
            && g>=g_min && g<=g_max
            && b>=b_min && b<=b_max) ? 1:0;
      }
  }
  //----------------------
  StartLookUp:
  if (mode==5 || mode==3)
    { x1=sx; y1=sy; x2=sx+sw-w; y2=sy+sh-h; sx=0; sy=0; }
  else
    { x1=0; y1=0; x2=sw-w; y2=sh-h; }
  if (dir<1 || dir>8) dir=1;
  // 1 ==> Top to Bottom ( Left to Right )
  // 2 ==> Top to Bottom ( Right to Left )
  // 3 ==> Bottom to Top ( Left to Right )
  // 4 ==> Bottom to Top ( Right to Left )
  // 5 ==> Left to Right ( Top to Bottom )
  // 6 ==> Left to Right ( Bottom to Top )
  // 7 ==> Right to Left ( Top to Bottom )
  // 8 ==> Right to Left ( Bottom to Top )
  if (--dir>3) { i=y1; y1=x1; x1=i; i=y2; y2=x2; x2=i; }
  for (y3=y1; y3<=y2; y3++)
  {
    for (x3=x1; x3<=x2; x3++)
    {
      y=((dir&3)>1) ? y1+y2-y3 : y3;
      x=(dir&1) ? x1+x2-x3 : x3;
      if (dir>3) { i=y; y=x; x=i; }
      //----------------------
      e1=err1; e0=err0;
      if (mode==5)
      {
        o=y*Stride+x*4;
        for (i=0; i<max; i++)
        {
          j=o+s1[i]; c=s0[i]; r=Bmp[2+j]-((c>>16)&0xFF);
          g=Bmp[1+j]-((c>>8)&0xFF); b=Bmp[j]-(c&0xFF);
          if ((r*r>v || g*g>v || b*b>v) && (--e1)<0)
            goto NoMatch;
        }
      }
      else if (mode==3)
      {
        o=y*Stride+x*4;
        j=o+c; rr=Bmp[2+j]; gg=Bmp[1+j]; bb=Bmp[j];
        for (i=0; i<max; i++)
        {
          if (i<len1)
          {
            j=o+s1[i]; r=Bmp[2+j]-rr; g=Bmp[1+j]-gg; b=Bmp[j]-bb; v=r+rr+rr;
            if ((1024+v)*r*r+2048*g*g+(1534-v)*b*b>n && (--e1)<0)
              goto NoMatch;
          }
          if (i<len0)
          {
            j=o+s0[i]; r=Bmp[2+j]-rr; g=Bmp[1+j]-gg; b=Bmp[j]-bb; v=r+rr+rr;
            if ((1024+v)*r*r+2048*g*g+(1534-v)*b*b<=n && (--e0)<0)
              goto NoMatch;
          }
        }
      }
      else
      {
        o=y*sw+x;
        for (i=0; i<max; i++)
        {
          if (i<len1 && ss[o+s1[i]]==0 && (--e1)<0) goto NoMatch;
          if (i<len0 && ss[o+s0[i]]!=0 && (--e0)<0) goto NoMatch;
        }
        // Clear the image that has been found
        for (i=0; i<len1; i++)
          ss[o+s1[i]]=0;
      }
      allpos[ok*2]=sx+x; allpos[ok*2+1]=sy+y;
      if (++ok>=allpos_max) goto Return1;
      NoMatch:;
    }
  }
  //----------------------
  Return1:
  return ok;
}

*/


;==== Optional GUI interface ====


Gui(cmd, arg1:="")
{
  local
  static
  local bch, cri
  static init:=0
  if (!init)
  {
    init:=1
    Gui_ := this.Gui.Bind(this)
    Gui_G := this.Gui.Bind(this, "G")
    Gui_Run := this.Gui.Bind(this, "Run")
    Gui_Off := this.Gui.Bind(this, "Off")
    Gui_Show := this.Gui.Bind(this, "Show")
    Gui_KeyDown := this.Gui.Bind(this, "KeyDown")
    Gui_LButtonDown := this.Gui.Bind(this, "LButtonDown")
    Gui_MouseMove := this.Gui.Bind(this, "MouseMove")
    Gui_ScreenShot := this.Gui.Bind(this, "ScreenShot")
    Gui_ShowPic := this.Gui.Bind(this, "ShowPic")
    Gui_Slider := this.Gui.Bind(this, "Slider")
    Gui_ToolTip := this.Gui.Bind(this, "ToolTip")
    Gui_ToolTipOff := this.Gui.Bind(this, "ToolTipOff")
    Gui_SaveScr := this.Gui.Bind(this, "SaveScr")
    bch:=A_BatchLines, cri:=A_IsCritical
    Critical
    #NoEnv
    %Gui_%("Load_Language_Text")
    %Gui_%("MakeCaptureWindow")
    %Gui_%("MakeMainWindow")
    OnMessage(0x100, Gui_KeyDown)
    OnMessage(0x201, Gui_LButtonDown)
    OnMessage(0x200, Gui_MouseMove)
    Menu, Tray, Add
    Menu, Tray, Add, % Lang["s1"], %Gui_Show%
    if (!A_IsCompiled and A_LineFile=A_ScriptFullPath)
    {
      Menu, Tray, Default, % Lang["s1"]
      Menu, Tray, Click, 1
      Menu, Tray, Icon, Shell32.dll, 23
    }
    Critical, %cri%
    SetBatchLines, %bch%
  }
  Switch cmd
  {
  Case "Off":
    return (KeyDown:=1)
  Case "G":
    GuiControl, +g, %id%, %Gui_Run%
    return
  Case "Run":
    Critical
    %Gui_%(A_GuiControl)
    return
  Case "Show":
    Gui, FindText_Main: Default
    Gui, Show, Center
    GuiControl, Focus, scr
    return
  Case "MakeCaptureWindow":
    ww:=35, hh:=12, WindowColor:="0xDDEEFF"
    Gui, FindText_Capture: New
    Gui, +AlwaysOnTop -DPIScale
    Gui, Margin, 15, 15
    Gui, Color, %WindowColor%
    Gui, Font, s12, Verdana
    Gui, -Theme
    nW:=71, nH:=25, w:=11, C_:=[], Cid_:=[]
    Loop % nW*(nH+1)
    {
      i:=A_Index, j:=i=1 ? "" : Mod(i,nW)=1 ? "xm y+1":"x+1"
      Gui, Add, Progress, w%w% h%w% %j% Hwndid
      Control, ExStyle, -0x20000,, ahk_id %id%
      C_[i]:=id, Cid_[id]:=i
    }
    Gui, +Theme
    GuiControlGet, p, Pos, %id%
    w:=pX+pW-15, h:=pY+pH-15
    Gui, Add, Slider, xm w%w% vMySlider1 Hwndid Disabled
      +Center Page20 Line10 NoTicks AltSubmit
    %Gui_G%()
    Gui, Add, Slider, ym h%h% vMySlider2 Hwndid Disabled
      +Center Page20 Line10 NoTicks AltSubmit +Vertical
    %Gui_G%()
    GuiControlGet, p, Pos, %id%
    k:=pX+pW, MySlider1:=MySlider2:=dx:=dy:=0
    ;--------------
    Gui, Add, Button, xm Hwndid Hidden Section, % Lang["Auto"]
    GuiControlGet, p, Pos, %id%
    w:=Round(pW*0.75), i:=Round(w*3+15+pW*0.5-w*1.5)
    Gui, Add, Button, xm+%i% yp w%w% hp -Wrap vRepU Hwndid, % Lang["RepU"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutU Hwndid, % Lang["CutU"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutU3 Hwndid, % Lang["CutU3"]
    %Gui_G%()
    Gui, Add, Button, xm wp hp -Wrap vRepL Hwndid, % Lang["RepL"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutL Hwndid, % Lang["CutL"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutL3 Hwndid, % Lang["CutL3"]
    %Gui_G%()
    Gui, Add, Button, x+15 w%pW% hp -Wrap vAuto Hwndid, % Lang["Auto"]
    %Gui_G%()
    Gui, Add, Button, x+15 w%w% hp -Wrap vRepR Hwndid, % Lang["RepR"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutR Hwndid, % Lang["CutR"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutR3 Hwndid, % Lang["CutR3"]
    %Gui_G%()
    Gui, Add, Button, xm+%i% wp hp -Wrap vRepD Hwndid, % Lang["RepD"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutD Hwndid, % Lang["CutD"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp hp -Wrap vCutD3 Hwndid, % Lang["CutD3"]
    %Gui_G%()
    ;--------------
    Gui, Add, Text, x+80 ys+3 Section, % Lang["SelGray"]
    Gui, Add, Edit, x+3 yp-3 w60 vSelGray ReadOnly
    Gui, Add, Text, x+15 ys, % Lang["SelColor"]
    Gui, Add, Edit, x+3 yp-3 w120 vSelColor ReadOnly
    Gui, Add, Text, x+15 ys, % Lang["SelR"]
    Gui, Add, Edit, x+3 yp-3 w60 vSelR ReadOnly
    Gui, Add, Text, x+5 ys, % Lang["SelG"]
    Gui, Add, Edit, x+3 yp-3 w60 vSelG ReadOnly
    Gui, Add, Text, x+5 ys, % Lang["SelB"]
    Gui, Add, Edit, x+3 yp-3 w60 vSelB ReadOnly
    ;--------------
    x:=w*6+pW+15*4
    Gui, Add, Tab3, x%x% y+15 -Wrap, % Lang["s2"]
    Gui, Tab, 1
    Gui, Add, Text, x+15 y+15, % Lang["Threshold"]
    Gui, Add, Edit, x+15 w100 vThreshold
    Gui, Add, Button, x+15 yp-3 vGray2Two Hwndid, % Lang["Gray2Two"]
    %Gui_G%()
    Gui, Tab, 2
    Gui, Add, Text, x+15 y+15, % Lang["GrayDiff"]
    Gui, Add, Edit, x+15 w100 vGrayDiff, 50
    Gui, Add, Button, x+15 yp-3 vGrayDiff2Two Hwndid, % Lang["GrayDiff2Two"]
    %Gui_G%()
    Gui, Tab, 3
    Gui, Add, Text, x+15 y+15, % Lang["Similar1"] " 0"
    Gui, Add, Slider, x+0 w120 vSimilar1 Hwndid
      +Center Page1 NoTicks ToolTip, 100
    %Gui_G%()
    Gui, Add, Text, x+0, 100
    Gui, Add, Button, x+15 yp-3 vColor2Two Hwndid, % Lang["Color2Two"]
    %Gui_G%()
    Gui, Tab, 4
    Gui, Add, Text, x+15 y+15, % Lang["Similar2"] " 0"
    Gui, Add, Slider, x+0 w120 vSimilar2 Hwndid
      +Center Page1 NoTicks ToolTip, 100
    %Gui_G%()
    Gui, Add, Text, x+0, 100
    Gui, Add, Button, x+15 yp-3 vColorPos2Two Hwndid, % Lang["ColorPos2Two"]
    %Gui_G%()
    Gui, Tab, 5
    Gui, Add, Text, x+10 y+15, % Lang["DiffR"]
    Gui, Add, Edit, x+5 w80 vDiffR Limit3
    Gui, Add, UpDown, vdR Range0-255 Wrap
    Gui, Add, Text, x+5, % Lang["DiffG"]
    Gui, Add, Edit, x+5 w80 vDiffG Limit3
    Gui, Add, UpDown, vdG Range0-255 Wrap
    Gui, Add, Text, x+5, % Lang["DiffB"]
    Gui, Add, Edit, x+5 w80 vDiffB Limit3
    Gui, Add, UpDown, vdB Range0-255 Wrap
    Gui, Add, Button, x+15 yp-3 vColorDiff2Two Hwndid, % Lang["ColorDiff2Two"]
    %Gui_G%()
    Gui, Tab, 6
    Gui, Add, Text, x+10 y+15, % Lang["DiffRGB"]
    Gui, Add, Edit, x+5 w80 vDiffRGB Limit3
    Gui, Add, UpDown, vdRGB Range0-255 Wrap
    Gui, Add, Checkbox, x+15 yp+5 vMultiColor Hwndid, % Lang["MultiColor"]
    %Gui_G%()
    Gui, Add, Button, x+15 yp-5 vUndo Hwndid, % Lang["Undo"]
    %Gui_G%()
    Gui, Tab
    ;--------------
    Gui, Add, Button, xm vReset Hwndid, % Lang["Reset"]
    %Gui_G%()
    Gui, Add, Checkbox, x+15 yp+5 vModify Hwndid, % Lang["Modify"]
    %Gui_G%()
    Gui, Add, Text, x+30, % Lang["Comment"]
    Gui, Add, Edit, x+5 yp-2 w150 vComment
    Gui, Add, Button, x+30 yp-3 vSplitAdd Hwndid, % Lang["SplitAdd"]
    %Gui_G%()
    Gui, Add, Button, x+10 vAllAdd Hwndid, % Lang["AllAdd"]
    %Gui_G%()
    Gui, Add, Button, x+10 wp vOK Hwndid, % Lang["OK"]
    %Gui_G%()
    Gui, Add, Button, x+10 wp vCancel gCancel, % Lang["Cancel"]
    Gui, Add, Button, xm vBind0 Hwndid, % Lang["Bind0"]
    %Gui_G%()
    Gui, Add, Button, x+10 vBind1 Hwndid, % Lang["Bind1"]
    %Gui_G%()
    Gui, Add, Button, x+10 vBind2 Hwndid, % Lang["Bind2"]
    %Gui_G%()
    Gui, Add, Button, x+10 vBind3 Hwndid, % Lang["Bind3"]
    %Gui_G%()
    Gui, Add, Button, x+10 vBind4 Hwndid, % Lang["Bind4"]
    %Gui_G%()
    Gui, Add, Button, x+30 vSave Hwndid, % Lang["Save"]
    %Gui_G%()
    Gui, Show, Hide, % Lang["s3"]
    return
  Case "MakeMainWindow":
    Gui, FindText_Main: New
    Gui, +AlwaysOnTop -DPIScale
    Gui, Margin, 15, 10
    Gui, Color, %WindowColor%
    Gui, Font, s12, Verdana
    Gui, Add, Text, xm, % Lang["NowHotkey"]
    Gui, Add, Edit, x+5 w200 vNowHotkey ReadOnly
    Gui, Add, Hotkey, x+5 w200 vSetHotkey1
    Gui, Add, DDL, x+5 w180 vSetHotkey2
      , % "||F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|LWin|MButton"
      . "|ScrollLock|CapsLock|Ins|Esc|BS|Del|Tab|Home|End|PgUp|PgDn"
      . "|NumpadDot|NumpadSub|NumpadAdd|NumpadDiv|NumpadMult"
    Gui, Add, GroupBox, xm y+0 w280 h55 vMyGroup cBlack
    Gui, Add, Text, xp+15 yp+20 Section, % Lang["Myww"] ": "
    Gui, Add, Text, x+0 w60, %ww%
    Gui, Add, UpDown, vMyww Range1-100, %ww%
    Gui, Add, Text, x+15 ys, % Lang["Myhh"] ": "
    Gui, Add, Text, x+0 w60, %hh%
    Gui, Add, UpDown, vMyhh Hwndid Range1-100, %hh%
    GuiControlGet, p, Pos, %id%
    GuiControl, Move, MyGroup, % "w" (pX+pW) " h" (pH+30)
    x:=pX+pW+15*2
    Gui, Add, Button, x%x% ys-8 w150 vApply Hwndid, % Lang["Apply"]
    %Gui_G%()
    Gui, Add, Checkbox, x+30 ys vAddFunc, % Lang["AddFunc"] " FindText()"
    Gui, Add, Button, xm y+18 w144 vCutL2 Hwndid, % Lang["CutL2"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vCutR2 Hwndid, % Lang["CutR2"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vCutU2 Hwndid, % Lang["CutU2"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vCutD2 Hwndid, % Lang["CutD2"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vUpdate Hwndid, % Lang["Update"]
    %Gui_G%()
    Gui, Font, s6 bold, Verdana
    Gui, Add, Edit, xm y+10 w720 r20 vMyPic -Wrap
    Gui, Font, s12 norm, Verdana
    Gui, Add, Button, xm w240 vCapture Hwndid, % Lang["Capture"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vTest Hwndid, % Lang["Test"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vCopy Hwndid, % Lang["Copy"]
    %Gui_G%()
    Gui, Add, Button, xm y+0 wp vCaptureS Hwndid, % Lang["CaptureS"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vGetRange Hwndid, % Lang["GetRange"]
    %Gui_G%()
    Gui, Add, Button, x+0 wp vGetOffset Hwndid, % Lang["GetOffset"]
    %Gui_G%()
    Gui, Add, Edit, xm y+10 w180 hp vClipText
    Gui, Add, Button, x+0 vPaste Hwndid, % " " Lang["Paste"] " "
    %Gui_G%()
    Gui, Add, Button, x+0 vTestClip Hwndid, % " " Lang["TestClip"] " "
    %Gui_G%()
    Gui, Add, Button, x+0 vGetClipOffset Hwndid, % " " Lang["GetClipOffset"] " "
    %Gui_G%()
    Gui, Add, Edit, x+0 hp w150 hp vOffset Hwndid
    GuiControlGet, p, Pos, %id%
    w:=720+15-(pX+pW)
    Gui, Add, Button, x+0 w%w% hp vCopyOffset Hwndid, % Lang["CopyOffset"]
    %Gui_G%()
    Gui, Font, s12 cBlue, Verdana
    Gui, Add, Edit, xm w720 h300 vscr Hwndhscr -Wrap HScroll
    Gui, Show, Hide, % Lang["s4"]
    %Gui_%("LoadScr")
    OnExit(Gui_SaveScr)
    return
  Case "LoadScr":
    f:=A_Temp "\~scr1.tmp"
    FileRead, s, %f%
    GuiControl, FindText_Main:, scr, %s%
    return
  Case "SaveScr":
    f:=A_Temp "\~scr1.tmp"
    GuiControlGet, s, FindText_Main:, scr
    FileDelete, %f%
    FileAppend, %s%, %f%
    return
  Case "Capture","CaptureS":
    Gui, FindText_Main: +Hwndid
    if (show_gui:=(WinExist()=id))
    {
      WinMinimize
      Gui, FindText_Main: Hide
    }
    ShowScreenShot:=InStr(cmd,"CaptureS")
    if (ShowScreenShot)
    {
      this.ScreenShot(), f:=%Gui_%("SelectPic")
      if (f="") or !FileExist(f)
      {
        if (show_gui)
        {
          Gui, FindText_Main: Show
          GuiControl, FindText_Main: Focus, scr
        }
        Exit
      }
      this.ShowPic(f)
    }
    ;----------------------
    if GetKeyState("RButton")
      Send {RButton Up}
    if GetKeyState("Ctrl")
      Send {Ctrl Up}
    KeyDown:=0, State:=%Gui_%("State")
    Gui, FindText_HotkeyIf: New, -Caption +ToolWindow +E0x80000
    Gui, Show, NA x0 y0 w0 h0, FindText_HotkeyIf
    Hotkey, IfWinExist, FindText_HotkeyIf
    Hotkey, *RButton, %Gui_Off%, On UseErrorLevel
    CoordMode, Mouse
    w:=ww, h:=hh, oldx:=oldy:="", r:=StrSplit(Lang["s5"],"|")
    if (!show_gui)
      w:=20, h:=8
    Critical, Off
    Loop
    {
      Sleep, 50
      MouseGetPos, x, y, Bind_ID
      if (!show_gui)
      {
        w:=x<=1 ? w-1 : x>=A_ScreenWidth-2 ? w+1:w
        h:=y<=1 ? h-1 : y>=A_ScreenHeight-2 ? h+1:h
        w:=(w<1 ? 1:w), h:=(h<1 ? 1:h)
      }
      %Gui_%("Mini_Show")
      if (oldx=x and oldy=y)
        Continue
      oldx:=x, oldy:=y
      ToolTip, % r[1] " : " x "," y "`n" r[2]
    }
    Until (KeyDown=1) or (State!=%Gui_%("State"))
    timeout:=A_TickCount+3000
    While (A_TickCount<timeout) and (State!=%Gui_%("State"))
      Sleep, 50
    KeyDown:=0
    px:=x, py:=y, oldx:=oldy:=""
    Loop
    {
      Sleep, 50
      %Gui_%("Mini_Show")
      MouseGetPos, x1, y1
      if (oldx=x1 and oldy=y1)
        Continue
      oldx:=x1, oldy:=y1
      ToolTip, % r[1] " : " x "," y "`n" r[2]
    }
    Until (KeyDown=1) or (State!=%Gui_%("State"))
    timeout:=A_TickCount+3000
    While (A_TickCount<timeout) and (State!=%Gui_%("State"))
      Sleep, 50
    ToolTip
    Critical
    %Gui_%("Mini_Hide")
    Hotkey, *RButton, %Gui_Off%, Off UseErrorLevel
    Hotkey, IfWinExist
    Gui, FindText_HotkeyIf: Destroy
    if (ShowScreenShot)
      this.ShowPic()
    if (!show_gui)
      return [px-w, py-h, px+w, py+h]
    ;-----------------------
    %Gui_%("getcors", !ShowScreenShot)
    %Gui_%("Reset")
    Gui, FindText_Capture: Default
    Loop 71
      SendMessage, 0x2001, 0, 0xAAFFFF
        ,, % "ahk_id " C_[71*25+A_Index]
    Loop 6
      GuiControl,, Edit%A_Index%
    GuiControl,, Modify, % Modify:=0
    GuiControl,, MultiColor, % MultiColor:=0
    GuiControl,, GrayDiff, 50
    GuiControl, Focus, Gray2Two
    GuiControl, +Default, Gray2Two
    Gui, Show, Center
    Event:=Result:=""
    DetectHiddenWindows, Off
    Critical, Off
    Gui, +LastFound
    WinWaitClose, % "ahk_id " WinExist()
    Critical
    ToolTip
    Gui, FindText_Main: Default
    ;--------------------------------
    if (cors.bind!="")
    {
      WinGetTitle, tt, ahk_id %Bind_ID%
      WinGetClass, tc, ahk_id %Bind_ID%
      tt:=Trim(SubStr(tt,1,30) (tc ? " ahk_class " tc:""))
      tt:=StrReplace(RegExReplace(tt,"[;``]","``$0"),"""","""""")
      Result:="`nSetTitleMatchMode, 2`nid:=WinExist(""" tt """)"
        . "`nFindText().BindWindow(id" (cors.bind=0 ? "":"," cors.bind)
        . ")  `; " Lang["s6"] " this.BindWindow(0)`n`n" Result
    }
    if (Event="OK")
    {
      if (!A_IsCompiled)
      {
        FileRead, s, %A_LineFile%
        s:=SubStr(s, s~="i)\n[;=]+ Copy The")
      }
      else s:=""
      GuiControl,, scr, % Result "`n" s
      if !InStr(Result,"##")
        GuiControl,, MyPic, % Trim(this.ASCII(Result),"`n")
      Result:=s:=""
    }
    else if (Event="SplitAdd") or (Event="AllAdd")
    {
      GuiControlGet, s,, scr
      i:=j:=0, r:="<[^>\n]*>[^$\n]+\$[\w+/,.\-]+"
      While j:=RegExMatch(s,r,"",j+1)
        i:=InStr(s,"`n",0,j)
      GuiControl,, scr, % SubStr(s,1,i) . Result . SubStr(s,i+1)
      if !InStr(Result,"##")
        GuiControl,, MyPic, % Trim(this.ASCII(Result),"`n")
      Result:=s:=""
    }
    ;----------------------
    Gui, Show
    GuiControl, Focus, scr
    return
  Case "State":
    return GetKeyState((arg1?"LButton":"RButton"),"P")
      . "|" GetKeyState((arg1?"LButton":"RButton"))
      . "|" GetKeyState("Ctrl","P")
      . "|" GetKeyState("Ctrl")
  Case "SelectPic":
    Gui, FindText_SelectPic: +LastFoundExist
    IfWinExist
      return
    Pics:=[], Names:=[], s:=""
    Loop Files, % A_Temp "\Ahk_ScreenShot\*.bmp"
      Pics.Push(LoadPicture(v:=A_LoopFileFullPath))
      , Names.Push(v), s.="|" RegExReplace(v,"i)^.*\\|\.bmp$")
    Gui, FindText_SelectPic: New
    Gui, +LastFound +AlwaysOnTop -DPIScale
    Gui, Margin, 15, 15
    Gui, Font, s12, Verdana
    Gui, Add, Pic, HwndhPic w800 h500 +Border
    Gui, Add, ListBox, % "x+15 w120 hp vSelectBox Hwndid"
      . " AltSubmit 0x100 Choose1", % Trim(s,"|")
    %Gui_G%()
    Gui, Add, Button, xm w170 vOK2 Hwndid Default, % Lang["OK2"]
    %Gui_G%()
    Gui, Add, Button, x+15 wp vCancel2 gCancel, % Lang["Cancel2"]
    Gui, Add, Button, x+15 wp vClearAll Hwndid, % Lang["ClearAll"]
    %Gui_G%()
    Gui, Add, Button, x+15 wp vOpenDir Hwndid, % Lang["OpenDir"]
    %Gui_G%()
    Gui, Add, Button, x+15 wp vSavePic Hwndid, % Lang["SavePic"]
    %Gui_G%()
    GuiControl, Focus, SelectBox
    %Gui_%("SelectBox")
    Gui, Show,, Select ScreenShot
    ;-----------------------
    DetectHiddenWindows, Off
    Critical, Off
    file:=""
    WinWaitClose, % "ahk_id " WinExist()
    Critical
    Gui, Destroy
    Loop % Pics.Length()
      DllCall("DeleteObject", "Ptr",Pics[A_Index])
    Pics:="", Names:=""
    return file
  Case "SavePic":
    GuiControlGet, SelectBox
    f:=Names[SelectBox]
    Gui, Destroy
    Loop % Pics.Length()
      DllCall("DeleteObject", "Ptr",Pics[A_Index])
    Pics:="", Names:="", show_gui_bak:=show_gui
    this.ShowPic(f)
    Gui, FindText_Screen: +OwnDialogs
    Loop
    {
      pos:=%Gui_%("GetRange")
      MsgBox, 4100, Tip, % Lang["s15"] " !"
      IfMsgBox, Yes
        Break
    }
    %Gui_%("ScreenShot", pos[1] "|" pos[2] "|" pos[3] "|" pos[4] "|0")
    this.ShowPic()
    if (show_gui_bak)
    {
      GuiControl, FindText_Main: Focus, scr
      Gui, FindText_Main: Show
    }
    Exit
  Case "SelectBox":
    GuiControlGet, SelectBox
    if (hBM:=Pics[SelectBox])
    {
      this.GetBitmapWH(hBM, w, h)
      GuiControl,, %hPic%, % "*W" (w<800?0:800)
        . " *H" (h<500?0:500) " HBITMAP:*" hBM
    }
    return
  Case "OK2":
    GuiControlGet, SelectBox
    file:=Names[SelectBox]
    Gui, Hide
    return
  Case "ClearAll":
    FileDelete, % A_Temp "\Ahk_ScreenShot\*.bmp"
    Gui, Hide
    return
  Case "OpenDir":
    Run, % A_Temp "\Ahk_ScreenShot\"
    return
  Case "Mini_Show":
    Gui, FindText_Mini_4: +LastFoundExist
    IfWinNotExist
    {
      Loop 4
      {
        i:=A_Index
        Gui, FindText_Mini_%i%: +AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08000000
        Gui, FindText_Mini_%i%: Show, Hide, Mini
      }
    }
    d:=2, w:=w<0 ? 0:w, h:=h<0 ? 0:h, c:=A_MSec<500 ? "Red":"Blue"
    Loop 4
    {
      i:=A_Index
      x1:=Floor(i=3 ? x+w+1 : x-w-d)
      y1:=Floor(i=4 ? y+h+1 : y-h-d)
      w1:=Floor(i=1 or i=3 ? d : 2*(w+d)+1)
      h1:=Floor(i=2 or i=4 ? d : 2*(h+d)+1)
      Gui, FindText_Mini_%i%: Color, %c%
      Gui, FindText_Mini_%i%: Show, NA x%x1% y%y1% w%w1% h%h1%
    }
    return
  Case "Mini_Hide":
    Gui, FindText_Mini_4: +Hwndid
    Loop 4
      Gui, FindText_Mini_%A_Index%: Destroy
    WinWaitClose, ahk_id %id%,, 3
    return
  Case "getcors":
    this.xywh2xywh(px-ww,py-hh,2*ww+1,2*hh+1,x,y,w,h)
    if (w<1 or h<1)
      return
    SetBatchLines, % (bch:=A_BatchLines)?"-1":"-1"
    if (arg1)
      this.ScreenShot()
    cors:=[], gray:=[], k:=0
    Loop %nH%
    {
      j:=py-hh+A_Index-1, i:=px-ww
      Loop %nW%
        cors[++k]:=c:=this.GetColor(i++,j,0)
        , gray[k]:=(((c>>16)&0xFF)*38+((c>>8)&0xFF)*75+(c&0xFF)*15)>>7
    }
    cors.CutLeft:=Abs(px-ww-x)
    cors.CutRight:=Abs(px+ww-(x+w-1))
    cors.CutUp:=Abs(py-hh-y)
    cors.CutDown:=Abs(py+hh-(y+h-1))
    SetBatchLines, %bch%
    return
  Case "GetRange":
    Gui, FindText_Main: +Hwndid
    if (show_gui:=(WinExist()=id))
      Gui, FindText_Main: Hide
    ;---------------------
    Gui, FindText_GetRange: New
    Gui, +LastFound +AlWaysOnTop +ToolWindow -Caption -DPIScale +E0x08000000
    Gui, Color, White
    WinSet, Transparent, 10
    this.xywh2xywh(0,0,0,0,0,0,0,0,x,y,w,h)
    Gui, Show, NA x%x% y%y% w%w% h%h%, GetRange
    ;---------------------
    if GetKeyState("LButton")
      Send {LButton Up}
    if GetKeyState("Ctrl")
      Send {Ctrl Up}
    KeyDown:=0, State:=%Gui_%("State",1)
    Gui, FindText_HotkeyIf: New, -Caption +ToolWindow +E0x80000
    Gui, Show, NA x0 y0 w0 h0, FindText_HotkeyIf
    Hotkey, IfWinExist, FindText_HotkeyIf
    Hotkey, *LButton, %Gui_Off%, On UseErrorLevel
    Hotkey, *LButton Up, %Gui_Off%, On UseErrorLevel
    CoordMode, Mouse
    oldx:=oldy:="", r:=Lang["s7"]
    Critical, Off
    Loop
    {
      Sleep, 50
      MouseGetPos, x, y
      if (oldx=x and oldy=y)
        Continue
      oldx:=x, oldy:=y
      ToolTip, %r%
    }
    Until (KeyDown=1) or (State!=%Gui_%("State",1))
    KeyDown--
    px:=x, py:=y, oldx:=oldy:=""
    Loop
    {
      Sleep, 50
      MouseGetPos, x, y
      w:=Abs(px-x)//2, h:=Abs(py-y)//2, x:=(px+x)//2, y:=(py+y)//2
      %Gui_%("Mini_Show")
      if (oldx=x and oldy=y)
        Continue
      oldx:=x, oldy:=y
      ToolTip, %r%
    }
    Until (KeyDown=1) or (KeyDown<0 and State=%Gui_%("State",1))
    timeout:=A_TickCount+3000
    While (A_TickCount<timeout) and (State!=%Gui_%("State",1))
      Sleep, 50
    ToolTip
    Critical
    %Gui_%("Mini_Hide")
    Hotkey, *LButton, %Gui_Off%, Off UseErrorLevel
    Hotkey, *LButton Up, %Gui_Off%, Off UseErrorLevel
    Hotkey, IfWinExist
    Gui, FindText_HotkeyIf: Destroy
    Gui, FindText_GetRange: Destroy
    Clipboard:=p:=(x-w) ", " (y-h) ", " (x+w) ", " (y+h)
    if (!show_gui)
      return StrSplit(p, ",", " ")
    ;---------------------
    Gui, FindText_Main: Default
    GuiControlGet, s,, scr
    re:="i)(FindText\(\s*X\d*\s*,\s*Y\d*\s*,)([\d\s+\-]*,){4}"
    if RegExMatch(s, re, r)
    {
      s:=StrReplace(s, r, r1 " " p ",", 0, 1)
      GuiControl,, scr, %s%
    }
    Gui, Show
    return
  Case "Test","TestClip":
    Gui, FindText_Main: Default
    Gui, +LastFound
    WinMinimize
    Gui, Hide
    DetectHiddenWindows, Off
    WinWaitClose, % "ahk_id " WinExist()
    Sleep, 100
    ;----------------------
    if (cmd="Test")
      GuiControlGet, s,, scr
    else
      GuiControlGet, s,, ClipText
    if (!A_IsCompiled) and InStr(s,"MCode(") and (cmd="Test")
    {
      s:="`n#NoEnv`nMenu, Tray, Click, 1`n" s "`nExitApp`n"
      Thread:= new this.Thread(s)
      DetectHiddenWindows, On
      WinWait, % "ahk_class AutoHotkey ahk_pid " Thread.pid,, 3
      if (!ErrorLevel)
        WinWaitClose,,, 30
      Thread:=""  ; kill the Thread
    }
    else
    {
      Gui, +OwnDialogs
      t:=A_TickCount, n:=150000, X:=Y:=""
      , RegExMatch(s,"<[^>\n]*>[^$\n]+\$[\w+/,.\-]+",r)
      , v:=this.FindText(X,Y,-n, -n, n, n, 0, 0, r)
      r:=StrSplit(Lang["s8"],"|")
      MsgBox, 4096, Tip, % r[1] ":`t" Round(v.Length()) "`n`n"
        . r[2] ":`t" (A_TickCount-t) " " r[3] "`n`n"
        . r[4] ":`t" X ", " Y "`n`n"
        . r[5] ":`t<" (Comment:=v[1].id) ">", 3
      for i,j in v
        if (i<=2)
          this.MouseTip(j.x, j.y)
      v:="", Clipboard:=X "," Y
    }
    ;----------------------
    Gui, Show
    GuiControl, Focus, scr
    return
  Case "GetOffset","GetClipOffset":
    Gui, FindText_Main: Hide
    Gui, FindText_Capture: +LastFound
    %Gui_%("Capture")
    Gui, FindText_Main: Default
    if (cmd="GetOffset")
      GuiControlGet, s,, scr
    else
      GuiControlGet, s,, ClipText
    RegExMatch(s, "<[^>\n]*>[^$\n]+\$[\w+/,.\-]+", r)
    n:=150000, v:=this.FindText(X, Y, -n, -n, n, n, 0, 0, r)
    r:=StrReplace("X+" (px-X) ", Y+" (py-Y), "+-", "-")
    if (cmd="GetOffset")
    {
      s:=RegExReplace(s, "i)(\.Click\()[^,\n""]*,[^,)\n]*"
        , "$1" r, 0, 1)
      GuiControl,, scr, %s%
    }
    else
      GuiControl,, Offset, % v ? r:""
    Gui, Show
    GuiControl, Focus, scr
    s:=v:=""
    return
  Case "Paste":
    if RegExMatch(Clipboard, "\|?<[^>\n]*>[^$\n]+\$[\w+/,.\-]+", r)
    {
      GuiControl,, ClipText, %r%
      GuiControl,, MyPic, % Trim(this.ASCII(r),"`n")
    }
    return
  Case "CopyOffset":
    GuiControlGet, s,, Offset
    Clipboard:=s
    return
  Case "Copy":
    Gui, FindText_Main: Default
    ControlGet, s, Selected,,, ahk_id %hscr%
    if (s="")
    {
      GuiControlGet, s,, scr
      GuiControlGet, r,, AddFunc
      if (r != 1)
        s:=RegExReplace(s,"\n\K[\s;=]+ Copy The[\s\S]*")
    }
    Clipboard:=RegExReplace(s,"\R","`r`n")
    GuiControl, Focus, scr
    return
  Case "Apply":
    Gui, FindText_Main: Default
    GuiControlGet, NowHotkey
    GuiControlGet, SetHotkey1
    GuiControlGet, SetHotkey2
    if (NowHotkey!="")
      Hotkey, *%NowHotkey%,, Off UseErrorLevel
    k:=SetHotkey1!="" ? SetHotkey1 : SetHotkey2
    if (k!="")
      Hotkey, *%k%, %Gui_ScreenShot%, On UseErrorLevel
    GuiControl,, NowHotkey, %k%
    GuiControl,, SetHotkey1
    GuiControl, Choose, SetHotkey2, 0
    ;------------------------
    GuiControlGet, Myww
    GuiControlGet, Myhh
    if (Myww!=ww or Myhh!=hh)
    {
      nW:=71, dx:=dy:=0
      Loop % 71*25
        k:=A_Index, c:=WindowColor, %Gui_%("SetColor")
      ww:=Myww, hh:=Myhh, nW:=2*ww+1, nH:=2*hh+1
      i:=nW>71, j:=nH>25
      Gui, FindText_Capture: Default
      GuiControl, Enable%i%, MySlider1
      GuiControl, Enable%j%, MySlider2
      GuiControl,, MySlider1, % MySlider1:=0
      GuiControl,, MySlider2, % MySlider2:=0
    }
    return
  Case "ScreenShot":
    Critical
    f:=A_Temp "\Ahk_ScreenShot"
    if !InStr(r:=FileExist(f), "D")
    {
      if (r)
      {
        FileSetAttrib, -R, %f%
        FileDelete, %f%
      }
      FileCreateDir, %f%
    }
    Loop
      f:=A_Temp "\Ahk_ScreenShot\" Format("{:03d}",A_Index) ".bmp"
    Until !FileExist(f)
    this.SavePic(f, StrSplit(arg1,"|")*)
    Gui, FindText_Tip: New
    ; WS_EX_NOACTIVATE:=0x08000000, WS_EX_TRANSPARENT:=0x20
    Gui, +LastFound +AlwaysOnTop +ToolWindow -Caption -DPIScale +E0x08000020
    Gui, Color, Yellow
    Gui, Font, cRed s48 bold
    Gui, Add, Text,, % Lang["s9"]
    WinSet, Transparent, 200
    Gui, Show, NA y0, ScreenShot Tip
    Sleep, 100
    Gui, Destroy
    return
  Case "Bind0","Bind1","Bind2","Bind3","Bind4":
    this.BindWindow(Bind_ID, bind_mode:=SubStr(cmd,5))
    if GetKeyState("RButton")
      Send {RButton Up}
    if GetKeyState("Ctrl")
      Send {Ctrl Up}
    KeyDown:=0, State:=%Gui_%("State")
    Gui, FindText_HotkeyIf: New, -Caption +ToolWindow +E0x80000
    Gui, Show, NA x0 y0 w0 h0, FindText_HotkeyIf
    Hotkey, IfWinExist, FindText_HotkeyIf
    Hotkey, *RButton, %Gui_Off%, On UseErrorLevel
    CoordMode, Mouse
    oldx:=oldy:=""
    Critical, Off
    Loop
    {
      Sleep, 50
      MouseGetPos, x, y
      if (oldx=x and oldy=y)
        Continue
      oldx:=x, oldy:=y
      ;---------------
      px:=x, py:=y, %Gui_%("getcors",1)
      %Gui_%("Reset"), r:=StrSplit(Lang["s10"],"|")
      ToolTip, % r[1] " : " x "," y "`n" r[2]
    }
    Until (KeyDown=1) or (State!=%Gui_%("State"))
    timeout:=A_TickCount+3000
    While (A_TickCount<timeout) and (State!=%Gui_%("State"))
      Sleep, 50
    ToolTip
    Critical
    Hotkey, *RButton, %Gui_Off%, Off UseErrorLevel
    Hotkey, IfWinExist
    Gui, FindText_HotkeyIf: Destroy
    this.BindWindow(0), cors.bind:=bind_mode
    return
  Case "MySlider1","MySlider2":
    SetTimer, %Gui_Slider%, -10
    return
  Case "Slider":
    Critical
    dx:=nW>71 ? Round((nW-71)*MySlider1/100) : 0
    dy:=nH>25 ? Round((nH-25)*MySlider2/100) : 0
    if (oldx=dx and oldy=dy)
      return
    oldy:=dy, k:=0
    Loop % nW*nH
      c:=(!show[++k] ? WindowColor
      : bg="" ? cors[k] : ascii[k]
      ? "Black":"White"), %Gui_%("SetColor")
    Loop % nW*(oldx!=dx)
    {
      i:=A_Index-dx
      if (i>=1 && i<=71)
      {
        c:=show[nW*nH+A_Index] ? 0x0000FF : 0xAAFFFF
        SendMessage, 0x2001, 0, c,, % "ahk_id " C_[71*25+i]
      }
    }
    oldx:=dx
    return
  Case "Reset":
    show:=[], ascii:=[], bg:=""
    CutLeft:=CutRight:=CutUp:=CutDown:=k:=0
    Loop % nW*nH
      show[++k]:=1, c:=cors[k], %Gui_%("SetColor")
    Loop % cors.CutLeft
      %Gui_%("CutL")
    Loop % cors.CutRight
      %Gui_%("CutR")
    Loop % cors.CutUp
      %Gui_%("CutU")
    Loop % cors.CutDown
      %Gui_%("CutD")
    return
  Case "SetColor":
    if (nW=71 && nH=25)
      tk:=k
    else
    {
      tx:=Mod(k-1,nW)-dx, ty:=(k-1)//nW-dy
      if (tx<0 || tx>=71 || ty<0 || ty>=25)
        return
      tk:=ty*71+tx+1
    }
    c:=c="Black" ? 0x000000 : c="White" ? 0xFFFFFF
      : ((c&0xFF)<<16)|(c&0xFF00)|((c&0xFF0000)>>16)
    SendMessage, 0x2001, 0, c,, % "ahk_id " . C_[tk]
    return
  Case "RepColor":
    show[k]:=1, c:=(bg="" ? cors[k] : ascii[k]
      ? "Black":"White"), %Gui_%("SetColor")
    return
  Case "CutColor":
    show[k]:=0, c:=WindowColor, %Gui_%("SetColor")
    return
  Case "RepL":
    if (CutLeft<=cors.CutLeft)
    or (bg!="" and InStr(color,"**")
    and CutLeft=cors.CutLeft+1)
      return
    k:=CutLeft-nW, CutLeft--
    Loop %nH%
      k+=nW, (A_Index>CutUp and A_Index<nH+1-CutDown
        ? %Gui_%("RepColor") : "")
    return
  Case "CutL":
    if (CutLeft+CutRight>=nW)
      return
    CutLeft++, k:=CutLeft-nW
    Loop %nH%
      k+=nW, (A_Index>CutUp and A_Index<nH+1-CutDown
        ? %Gui_%("CutColor") : "")
    return
  Case "CutL3":
    Loop 3
      %Gui_%("CutL")
    return
  Case "RepR":
    if (CutRight<=cors.CutRight)
    or (bg!="" and InStr(color,"**")
    and CutRight=cors.CutRight+1)
      return
    k:=1-CutRight, CutRight--
    Loop %nH%
      k+=nW, (A_Index>CutUp and A_Index<nH+1-CutDown
        ? %Gui_%("RepColor") : "")
    return
  Case "CutR":
    if (CutLeft+CutRight>=nW)
      return
    CutRight++, k:=1-CutRight
    Loop %nH%
      k+=nW, (A_Index>CutUp and A_Index<nH+1-CutDown
        ? %Gui_%("CutColor") : "")
    return
  Case "CutR3":
    Loop 3
      %Gui_%("CutR")
    return
  Case "RepU":
    if (CutUp<=cors.CutUp)
    or (bg!="" and InStr(color,"**")
    and CutUp=cors.CutUp+1)
      return
    k:=(CutUp-1)*nW, CutUp--
    Loop %nW%
      k++, (A_Index>CutLeft and A_Index<nW+1-CutRight
        ? %Gui_%("RepColor") : "")
    return
  Case "CutU":
    if (CutUp+CutDown>=nH)
      return
    CutUp++, k:=(CutUp-1)*nW
    Loop %nW%
      k++, (A_Index>CutLeft and A_Index<nW+1-CutRight
        ? %Gui_%("CutColor") : "")
    return
  Case "CutU3":
    Loop 3
      %Gui_%("CutU")
    return
  Case "RepD":
    if (CutDown<=cors.CutDown)
    or (bg!="" and InStr(color,"**")
    and CutDown=cors.CutDown+1)
      return
    k:=(nH-CutDown)*nW, CutDown--
    Loop %nW%
      k++, (A_Index>CutLeft and A_Index<nW+1-CutRight
        ? %Gui_%("RepColor") : "")
    return
  Case "CutD":
    if (CutUp+CutDown>=nH)
      return
    CutDown++, k:=(nH-CutDown)*nW
    Loop %nW%
      k++, (A_Index>CutLeft and A_Index<nW+1-CutRight
        ? %Gui_%("CutColor") : "")
    return
  Case "CutD3":
    Loop 3
      %Gui_%("CutD")
    return
  Case "Gray2Two":
    Gui, FindText_Capture: Default
    GuiControl, Focus, Threshold
    GuiControlGet, Threshold
    if (Threshold="")
    {
      pp:=[]
      Loop 256
        pp[A_Index-1]:=0
      Loop % nW*nH
        if (show[A_Index])
          pp[gray[A_Index]]++
      IP0:=IS0:=0
      Loop 256
        k:=A_Index-1, IP0+=k*pp[k], IS0+=pp[k]
      Threshold:=Floor(IP0/IS0)
      Loop 20
      {
        LastThreshold:=Threshold
        IP1:=IS1:=0
        Loop % LastThreshold+1
          k:=A_Index-1, IP1+=k*pp[k], IS1+=pp[k]
        IP2:=IP0-IP1, IS2:=IS0-IS1
        if (IS1!=0 and IS2!=0)
          Threshold:=Floor((IP1/IS1+IP2/IS2)/2)
        if (Threshold=LastThreshold)
          Break
      }
      GuiControl,, Threshold, %Threshold%
    }
    Threshold:=Round(Threshold)
    color:="*" Threshold, k:=i:=0
    Loop % nW*nH
    {
      ascii[++k]:=v:=(gray[k]<=Threshold)
      if (show[k])
        i:=(v?i+1:i-1), c:=(v?"Black":"White"), %Gui_%("SetColor")
    }
    bg:=i>0 ? "1":"0"
    return
  Case "GrayDiff2Two":
    Gui, FindText_Capture: Default
    GuiControlGet, GrayDiff
    if (GrayDiff="")
    {
      Gui, +OwnDialogs
      MsgBox, 4096, Tip, % Lang["s11"] " !", 1
      return
    }
    if (CutLeft=cors.CutLeft)
      %Gui_%("CutL")
    if (CutRight=cors.CutRight)
      %Gui_%("CutR")
    if (CutUp=cors.CutUp)
      %Gui_%("CutU")
    if (CutDown=cors.CutDown)
      %Gui_%("CutD")
    GrayDiff:=Round(GrayDiff)
    color:="**" GrayDiff, k:=i:=0
    Loop % nW*nH
    {
      j:=gray[++k]+GrayDiff
      , ascii[k]:=v:=( gray[k-1]>j or gray[k+1]>j
      or gray[k-nW]>j or gray[k+nW]>j
      or gray[k-nW-1]>j or gray[k-nW+1]>j
      or gray[k+nW-1]>j or gray[k+nW+1]>j )
      if (show[k])
        i:=(v?i+1:i-1), c:=(v?"Black":"White"), %Gui_%("SetColor")
    }
    bg:=i>0 ? "1":"0"
    return
  Case "Color2Two","ColorPos2Two":
    Gui, FindText_Capture: Default
    GuiControlGet, c,, SelColor
    if (c="")
    {
      Gui, +OwnDialogs
      MsgBox, 4096, Tip, % Lang["s12"] " !", 1
      return
    }
    UsePos:=(cmd="ColorPos2Two") ? 1:0
    GuiControlGet, n,, Similar1
    n:=Round(n/100,2), color:=c "@" n
    , n:=Floor(512*9*255*255*(1-n)*(1-n)), k:=i:=0
    , rr:=(c>>16)&0xFF, gg:=(c>>8)&0xFF, bb:=c&0xFF
    Loop % nW*nH
    {
      c:=cors[++k], r:=((c>>16)&0xFF)-rr
      , g:=((c>>8)&0xFF)-gg, b:=(c&0xFF)-bb, j:=r+rr+rr
      , ascii[k]:=v:=((1024+j)*r*r+2048*g*g+(1534-j)*b*b<=n)
      if (show[k])
        i:=(v?i+1:i-1), c:=(v?"Black":"White"), %Gui_%("SetColor")
    }
    bg:=i>0 ? "1":"0"
    return
  Case "ColorDiff2Two":
    Gui, FindText_Capture: Default
    GuiControlGet, c,, SelColor
    if (c="")
    {
      Gui, +OwnDialogs
      MsgBox, 4096, Tip, % Lang["s12"] " !", 1
      return
    }
    GuiControlGet, dR
    GuiControlGet, dG
    GuiControlGet, dB
    rr:=(c>>16)&0xFF, gg:=(c>>8)&0xFF, bb:=c&0xFF
    , n:=Format("{:06X}",(dR<<16)|(dG<<8)|dB)
    , color:=StrReplace(c "-" n,"0x"), k:=i:=0
    Loop % nW*nH
    {
      c:=cors[++k], r:=(c>>16)&0xFF, g:=(c>>8)&0xFF
      , b:=c&0xFF, ascii[k]:=v:=(Abs(r-rr)<=dR
      and Abs(g-gg)<=dG and Abs(b-bb)<=dB)
      if (show[k])
        i:=(v?i+1:i-1), c:=(v?"Black":"White"), %Gui_%("SetColor")
    }
    bg:=i>0 ? "1":"0"
    return
  Case "Modify":
    GuiControlGet, Modify
    return
  Case "MultiColor":
    GuiControlGet, MultiColor
    Result:=""
    ToolTip
    return
  Case "Undo":
    Result:=RegExReplace(Result,",[^/]+/[^/]+/[^/]+$")
    ToolTip, % Trim(Result,"/,")
    return
  Case "Similar1":
    GuiControl,, Similar2, %Similar1%
    return
  Case "Similar2":
    GuiControl,, Similar1, %Similar2%
    return
  Case "GetTxt":
    txt:=""
    if (bg="")
      return
    k:=0
    Loop %nH%
    {
      v:=""
      Loop %nW%
        v.=!show[++k] ? "" : ascii[k] ? "1":"0"
      txt.=v="" ? "" : v "`n"
    }
    return
  Case "Auto":
    %Gui_%("GetTxt")
    if (txt="")
    {
      Gui, FindText_Capture: +OwnDialogs
      MsgBox, 4096, Tip, % Lang["s13"] " !", 1
      return
    }
    While InStr(txt,bg)
    {
      if (txt~="^" bg "+\n")
        txt:=RegExReplace(txt,"^" bg "+\n"), %Gui_%("CutU")
      else if !(txt~="m`n)[^\n" bg "]$")
        txt:=RegExReplace(txt,"m`n)" bg "$"), %Gui_%("CutR")
      else if (txt~="\n" bg "+\n$")
        txt:=RegExReplace(txt,"\n\K" bg "+\n$"), %Gui_%("CutD")
      else if !(txt~="m`n)^[^\n" bg "]")
        txt:=RegExReplace(txt,"m`n)^" bg), %Gui_%("CutL")
      else Break
    }
    txt:=""
    return
  Case "OK","SplitAdd","AllAdd":
    Gui, FindText_Capture: Default
    Gui, +OwnDialogs
    %Gui_%("GetTxt")
    if (txt="") and (!MultiColor)
    {
      MsgBox, 4096, Tip, % Lang["s13"] " !", 1
      return
    }
    if InStr(color,"@") and (UsePos) and (!MultiColor)
    {
      r:=StrSplit(color,"@")
      k:=i:=j:=0
      Loop % nW*nH
      {
        if (!show[++k])
          Continue
        i++
        if (k=cors.SelPos)
        {
          j:=i
          Break
        }
      }
      if (j=0)
      {
        MsgBox, 4096, Tip, % Lang["s12"] " !", 1
        return
      }
      color:="#" (j-1) "@" r[2]
    }
    GuiControlGet, Comment
    if (cmd="SplitAdd") and (!MultiColor)
    {
      if InStr(color,"#")
      {
        MsgBox, 4096, Tip, % Lang["s14"], 3
        return
      }
      bg:=StrLen(StrReplace(txt,"0"))
        > StrLen(StrReplace(txt,"1")) ? "1":"0"
      s:="", i:=0, k:=nW*nH+1+CutLeft
      Loop % w:=nW-CutLeft-CutRight
      {
        i++
        if (!show[k++] and A_Index<w)
          Continue
        i:=Format("{:d}",i)
        v:=RegExReplace(txt,"m`n)^(.{" i "}).*","$1")
        txt:=RegExReplace(txt,"m`n)^.{" i "}"), i:=0
        While InStr(v,bg)
        {
          if (v~="^" bg "+\n")
            v:=RegExReplace(v,"^" bg "+\n")
          else if !(v~="m`n)[^\n" bg "]$")
            v:=RegExReplace(v,"m`n)" bg "$")
          else if (v~="\n" bg "+\n$")
            v:=RegExReplace(v,"\n\K" bg "+\n$")
          else if !(v~="m`n)^[^\n" bg "]")
            v:=RegExReplace(v,"m`n)^" bg)
          else Break
        }
        if (v!="")
        {
          v:=Format("{:d}",InStr(v,"`n")-1) "." this.bit2base64(v)
          s.="`nText.=""|<" SubStr(Comment,1,1) ">" color "$" v """`n"
          Comment:=SubStr(Comment, 2)
        }
      }
      Event:=cmd, Result:=s
      Gui, Hide
      return
    }
    if (!MultiColor)
      txt:=Format("{:d}",InStr(txt,"`n")-1) "." this.bit2base64(txt)
    else
    {
      GuiControlGet, dRGB
      r:=StrSplit(Trim(StrReplace(Result,",","/"),"/"),"/")
      , x:=r[1], y:=r[2], s:="", i:=1
      Loop % r.Length()//3
        s.="," (r[i++]-x) "/" (r[i++]-y) "/" r[i++]
      txt:=SubStr(s,2), color:="##" dRGB
    }
    s:="`nText.=""|<" Comment ">" color "$" txt """`n"
    if (cmd="AllAdd")
    {
      Event:=cmd, Result:=s
      Gui, Hide
      return
    }
    x:=px-ww+CutLeft+(nW-CutLeft-CutRight)//2
    y:=py-hh+CutUp+(nH-CutUp-CutDown)//2
    s:=StrReplace(s, "Text.=", "Text:="), r:=StrSplit(Lang["s8"],"|")
    s:="`; #Include <FindText>`n"
    . "`nt1:=A_TickCount, X:=Y:=""""`n" s
    . "`nif (ok:=FindText(X, Y, " x "-150000, "
    . y "-150000, " x "+150000, " y "+150000, 0, 0, Text))"
    . "`n{"
    . "`n  `; FindText().Click(" . "X, Y, ""L"")"
    . "`n}`n"
    . "`n`; ok:=FindText(""wait"",3, 0,0,0,0,0,0,Text)    `; Wait 3 seconds for appear"
    . "`n`; ok:=FindText(""wait0"",-1, 0,0,0,0,0,0,Text)  `; Wait indefinitely for disappear`n"
    . "`nMsgBox, 4096, Tip, `% """ r[1] ":``t"" Round(ok.Length())"
    . "`n  . ""``n``n" r[2] ":``t"" (A_TickCount-t1) "" " r[3] """"
    . "`n  . ""``n``n" r[4] ":``t"" X "", "" Y"
    . "`n  . ""``n``n" r[5] ":``t<"" (Comment:=ok[1].id) "">""`n"
    . "`nfor i,v in ok"
    . "`n  if (i<=2)"
    . "`n    FindText().MouseTip(ok[i].x, ok[i].y)`n"
    Event:=cmd, Result:=s
    Gui, Hide
    return
  Case "Save":
    x:=px-ww+CutLeft, w:=nW-CutLeft-CutRight
    y:=py-hh+CutUp, h:=nH-CutUp-CutDown
    %Gui_%("ScreenShot"
      , x "|" y "|" (x+w-1) "|" (y+h-1) "|0")
    return
  Case "KeyDown":
    Critical
    if (A_Gui!="FindText_Main")
      return
    if (A_GuiControl="scr")
      SetTimer, %Gui_ShowPic%, -150
    else if (A_GuiControl="ClipText")
    {
      GuiControlGet, s, FindText_Main:, ClipText
      GuiControl, FindText_Main:, MyPic, % Trim(this.ASCII(s),"`n")
    }
    return
  Case "ShowPic":
    ControlGet, i, CurrentLine,,, ahk_id %hscr%
    ControlGet, s, Line, %i%,, ahk_id %hscr%
    GuiControl, FindText_Main:, MyPic, % Trim(this.ASCII(s),"`n")
    return
  Case "LButtonDown":
    Critical
    if (A_Gui!="FindText_Capture")
      return %Gui_%("KeyDown")
    MouseGetPos,,,, k2, 2
    if (k1:=Round(Cid_[k2]))<1
      return
    Gui, FindText_Capture: Default
    if (k1>71*25)
    {
      k3:=nW*nH+(k1-71*25)+dx
      k1:=(show[k3]:=!show[k3]) ? 0x0000FF : 0xAAFFFF
      SendMessage, 0x2001, 0, k1,, % "ahk_id " k2
      return
    }
    k2:=Mod(k1-1,71)+dx, k3:=(k1-1)//71+dy
    if (k2>=nW || k3>=nH)
      return
    k1:=k, k:=k3*nW+k2+1, k2:=c
    if (MultiColor and show[k])
    {
      c:="," Mod(k-1,nW) "/" k3 "/"
      . Format("{:06X}",cors[k]&0xFFFFFF)
      , Result.=InStr(Result,c) ? "":c
      ToolTip, % Trim(Result,"/,")
    }
    else if (Modify and bg!="" and show[k])
    {
      c:=((ascii[k]:=!ascii[k]) ? "Black":"White")
      , %Gui_%("SetColor")
    }
    else
    {
      c:=cors[k], cors.SelPos:=k
      GuiControl,, SelGray, % gray[k]
      GuiControl,, SelColor, % Format("0x{:06X}",c&0xFFFFFF)
      GuiControl,, SelR, % (c>>16)&0xFF
      GuiControl,, SelG, % (c>>8)&0xFF
      GuiControl,, SelB, % c&0xFF
    }
    k:=k1, c:=k2
    return
  Case "MouseMove":
    static PrevControl:=""
    if (PrevControl!=A_GuiControl)
    {
      PrevControl:=A_GuiControl
      SetTimer, %Gui_ToolTip%, % PrevControl ? -500 : "Off"
      SetTimer, %Gui_ToolTipOff%, % PrevControl ? -5500 : "Off"
      ToolTip
    }
    return
  Case "ToolTip":
    MouseGetPos,,, _TT
    IfWinExist, ahk_id %_TT% ahk_class AutoHotkeyGUI
      ToolTip, % Tip_Text[PrevControl]
    return
  Case "ToolTipOff":
    ToolTip
    return
  Case "CutL2","CutR2","CutU2","CutD2":
    Gui, FindText_Main: Default
    GuiControlGet, s,, MyPic
    s:=Trim(s,"`n") . "`n", v:=SubStr(cmd,4,1)
    if (v="U")
      s:=RegExReplace(s,"^[^\n]+\n")
    else if (v="D")
      s:=RegExReplace(s,"[^\n]+\n$")
    else if (v="L")
      s:=RegExReplace(s,"m`n)^[^\n]")
    else if (v="R")
      s:=RegExReplace(s,"m`n)[^\n]$")
    GuiControl,, MyPic, % Trim(s,"`n")
    return
  Case "Update":
    Gui, FindText_Main: Default
    GuiControl, Focus, scr
    ControlGet, i, CurrentLine,,, ahk_id %hscr%
    ControlGet, s, Line, %i%,, ahk_id %hscr%
    if !RegExMatch(s,"(<[^>\n]*>[^$\n]+\$)\d+\.[\w+/]+",r)
      return
    GuiControlGet, v,, MyPic
    v:=Trim(v,"`n") . "`n", w:=Format("{:d}",InStr(v,"`n")-1)
    v:=StrReplace(StrReplace(v,"0","1"),"_","0")
    s:=StrReplace(s,r,r1 . w "." this.bit2base64(v))
    v:="{End}{Shift Down}{Home}{Shift Up}{Del}"
    ControlSend,, %v%, ahk_id %hscr%
    Control, EditPaste, %s%,, ahk_id %hscr%
    ControlSend,, {Home}, ahk_id %hscr%
    return
  Case "Load_Language_Text":
    s:="
    (
Myww       = Width = Adjust the width of the capture range
Myhh       = Height = Adjust the height of the capture range
AddFunc    = Add = Additional FindText() in Copy
NowHotkey  = Hotkey = Current screenshot hotkey
SetHotkey1 = = First sequence Screenshot hotkey
SetHotkey2 = = Second sequence Screenshot hotkey
Apply      = Apply = Apply new screenshot hotkey and adjusted capture range values
CutU2      = CutU = Cut the Upper Edge of the text in the edit box below
CutL2      = CutL = Cut the Left Edge of the text in the edit box below
CutR2      = CutR = Cut the Right Edge of the text in the edit box below
CutD2      = CutD = Cut the Lower Edge of the text in the edit box below
Update     = Update = Update the text in the edit box below to the line of Code
GetRange   = GetRange = Get screen range to clipboard and update the search range of the Code
GetOffset  = GetOffset = Get position offset relative to the Text from the Code and update FindText().Click()
GetClipOffset  = GetOffset2 = Get position offset relative to the Text from the Left Box
Capture    = Capture = Initiate Image Capture Sequence
CaptureS   = CaptureS = Restore the Saved ScreenShot by Hotkey and then start capturing
Test       = Test = Test the Text from the Code to see if it can be found on the screen
TestClip   = Test2 = Test the Text from the Left Box and copy the result to Clipboard
Paste      = Paste = Paste the Text from Clipboard to the Left Box
CopyOffset = Copy2 = Copy the Offset to Clipboard
Copy       = Copy = Copy the selected or all of the code to the clipboard
Reset      = Reset = Reset to Original Captured Image
SplitAdd   = SplitAdd = Using Markup Segmentation to Generate Text Library
AllAdd     = AllAdd = Append Another FindText Search Text into Previously Generated Code
OK         = OK = Create New FindText Code for Testing
Cancel     = Cancel = Close the Window Don't Do Anything
Save       = SavePic = Save the trimmed original image to the default directory
Gray2Two      = Gray2Two = Converts Image Pixels from Gray Threshold to Black or White
GrayDiff2Two  = GrayDiff2Two = Converts Image Pixels from Gray Difference to Black or White
Color2Two     = Color2Two = Converts Image Pixels from Color Similar to Black or White
ColorPos2Two  = ColorPos2Two = Converts Image Pixels from Color Position to Black or White
ColorDiff2Two = ColorDiff2Two = Converts Image Pixels from Color Difference to Black or White
SelGray    = Gray = Gray value of the selected color
SelColor   = Color = The selected color
SelR       = R = Red component of the selected color
SelG       = G = Green component of the selected color
SelB       = B = Blue component of the selected color
RepU       = -U = Undo Cut the Upper Edge by 1
CutU       = U = Cut the Upper Edge by 1
CutU3      = U3 = Cut the Upper Edge by 3
RepL       = -L = Undo Cut the Left Edge by 1
CutL       = L = Cut the Left Edge by 1
CutL3      = L3 = Cut the Left Edge by 3
Auto       = Auto = Automatic Cut Edge after image has been converted to black and white
RepR       = -R = Undo Cut the Right Edge by 1
CutR       = R = Cut the Right Edge by 1
CutR3      = R3 = Cut the Right Edge by 3
RepD       = -D = Undo Cut the Lower Edge by 1
CutD       = D = Cut the Lower Edge by 1
CutD3      = D3 = Cut the Lower Edge by 3
Modify     = Modify = Allows Modify the Black and White Image
MultiColor = FindMultiColor = Click multiple colors with the mouse, then Click OK button
Undo       = Undo = Undo the last selected color
Comment    = Comment = Optional Comment used to Label Code ( Within <> )
Threshold  = Gray Threshold = Gray Threshold which Determines Black or White Pixel Conversion (0-255)
GrayDiff   = Gray Difference = Gray Difference which Determines Black or White Pixel Conversion (0-255)
Similar1   = Similarity = Adjust color similarity as Equivalent to The Selected Color
Similar2   = Similarity = Adjust color similarity as Equivalent to The Selected Color
DiffR      = R = Red Difference which Determines Black or White Pixel Conversion (0-255)
DiffG      = G = Green Difference which Determines Black or White Pixel Conversion (0-255)
DiffB      = B = Blue Difference which Determines Black or White Pixel Conversion (0-255)
DiffRGB    = R/G/B = Determine the allowed R/G/B Error (0-255) when Find MultiColor
Bind0      = BindWin1 = Bind the window and Use GetDCEx() to get the image of background window
Bind1      = BindWin1+ = Bind the window Use GetDCEx() and Modify the window to support transparency
Bind2      = BindWin2 = Bind the window and Use PrintWindow() to get the image of background window
Bind3      = BindWin2+ = Bind the window Use PrintWindow() and Modify the window to support transparency
Bind4      = BindWin3 = Bind the window and Use PrintWindow(,,3) to get the image of background window
OK2        = OK = Restore this ScreenShot
Cancel2    = Cancel = Close the Window Don't Do Anything
ClearAll   = ClearAll = Clean up all saved ScreenShots
OpenDir    = OpenDir = Open the saved screenshots directory
SavePic    = SavePic = Select a range and save as a picture
ClipText   = = Displays the Text data from clipboard
Offset     = = Displays the results of GetOffset2
s1  = FindText
s2  = Gray|GrayDiff|Color|ColorPos|ColorDiff|MultiColor
s3  = Capture Image To Text
s4  = Capture Image To Text And Find Text Tool
s5  = Position|First click RButton\nMove the mouse away\nSecond click RButton
s6  = Unbind Window using
s7  = Please drag a range with the LButton\nCoordinates are copied to clipboard
s8  = Found|Time|ms|Pos|Result
s9  = Success
s10 = The Capture Position|Perspective binding window\nRight click to finish capture
s11 = Please Set Gray Difference First
s12 = Please select the core color first
s13 = Please convert the image to black or white first
s14 = Can't be used in ColorPos mode, because it can cause position errors
s15 = Are you sure about the scope of your choice?\n\nIf not, you can choose again
    )"
    Lang:=[], Tip_Text:=[]
    Loop Parse, s, `n, `r
      if InStr(v:=A_LoopField, "=")
        r:=StrSplit(StrReplace(v,"\n","`n"), "=", "`t ")
        , Lang[r[1]]:=r[2], Tip_Text[r[1]]:=r[3]
    return
  }
}

}  ;// Class End

;================= The End =================