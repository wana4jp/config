; / ----- /
; functions
; / ----- /
IMESet(SetSts, WinTitle="A")    {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x006  ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}
PushLeft()
{
   SysGet, m, MonitorWorkArea, 1
   mX := mLeft
   mY := mTop
   mW := mRight - mLeft
   mH := mBottom - mTop

   WinGetPos,X,Y,W,H,A
   WinMove,A,,0,0,(mW / 2),mH
}
PushRight()
{
   SysGet, m, MonitorWorkArea, 1
   mX := mLeft
   mY := mTop
   mW := mRight - mLeft
   mH := mBottom - mTop

   WinGetPos,X,Y,W,H,A
   WinMove,A,,(mW / 2),0,(mW / 2),mH
}
PushWhole()
{
   SysGet, m, MonitorWorkArea, 1
   mX := mLeft
   mY := mTop
   mW := mRight - mLeft
   mH := mBottom - mTop

   WinGetPos,X,Y,W,H,A
   WinMove,A,,0,0,mW,mH
}


; / ----- /
; mappings
; / ----- /
vk1Dsc07B :: IMESet(0)
vkF2sc070 :: IMESet(1)
vk1Csc079 :: IMESet(1)
vk1Dsc07B & h::Send,{Blind}{Left}
vk1Dsc07B & j::Send,{Blind}{Down}
vk1Dsc07B & k::Send,{Blind}{Up}
vk1Dsc07B & l::Send,{Blind}{Right}

#LEFT::PushLeft()
#RIGHT::PushRight()
#UP::PushWhole()

; Vim でESC時にIMEをOFFにする
GroupAdd Vim, ahk_class PuTTY
GroupAdd Vim, ahk_class mintty ; cygwin
GroupAdd Vim, ahk_class VTWin32 ; teraterm

if WinActive("ahk_group Vim") or WinActive("ahk_exe idea.exe")
{
  $Esc::
  IMESet(0)
  Send {Esc}
  return

  ^[::
  IMESet(0)
  Send {Esc}
  return
}
