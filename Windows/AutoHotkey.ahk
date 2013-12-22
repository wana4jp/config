; ---------
; functions
; ---------
IME_SET(SetSts, WinTitle="A") {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if(WinActive(WinTitle)) {
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
		VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
		NumPut(cbSize, stGTI,  0, "UInt");
		DWORD cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
		? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

	return DllCall("SendMessage"
		, UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
		, UInt, 0x0283  ;Message : WM_IME_CONTROL
		,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
		,  Int, SetSts) ;lParam  : 0 or 1
}

SendToTargetMonitor(monitorNo)
{
	WinGetPos, x, y, w, h, A
	GetMonitor(monitorNo, mX, mY, mW, mH)
	WinMove, A,, mX, mY, mW, mH
	DllCall("SetCursorPos", int, (mX+200), int, (mY+400))
}

GetMonitor(monitorNo, ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
	SysGet, m, MonitorWorkArea, %monitorNo%
	mX := mLeft
	mY := mTop
	mW := mRight - mLeft
	mH := mBottom - mTop
}

ViewInTwoDisplay()
{
	WinGetPos, x, y, w, h, A
	;GetTwoDisplayMonitor(mX, mY, mW, mH)
	WinMove, A,, -2160, 0, 2160, 1919
}

MoveMouseToTargetMonitor(monitorNo)
{
	WinGetPos, x, y, w, h, A
	GetMonitor(monitorNo, mX, mY, mW, mH)
	DllCall("SetCursorPos", int, (mX+200), int, (mY+400))
}


; ---------
; mappings
; ---------
vk1Dsc07B :: IME_SET(0)
vkF2sc070 :: IME_SET(1)
vk1Csc079 :: IME_SET(1)
vk1Dsc07B & 7::MoveMouseToTargetMonitor(2)
vk1Dsc07B & 8::MoveMouseToTargetMonitor(3)
vk1Dsc07B & 9::MoveMouseToTargetMonitor(1)
vk1Dsc07B & Down::ViewInTwoDisplay()
vk1Dsc07B & Left::SendToTargetMonitor(2)
vk1Dsc07B & Right::SendToTargetMonitor(1)
vk1Dsc07B & Space::Send,{Blind}{Enter}
vk1Dsc07B & Up::SendToTargetMonitor(3)
vk1Dsc07B & h::Send,{Blind}{Left}
vk1Dsc07B & j::Send,{Blind}{Down}
vk1Dsc07B & k::Send,{Blind}{Up}
vk1Dsc07B & l::Send,{Blind}{Right}
