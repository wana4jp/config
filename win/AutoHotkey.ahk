; ---------
; functions
; ---------
IME_SET(SetSts, WinTitle="A")    {
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

; ---------
; mappings
; ---------
vk1Dsc07B :: IME_SET(0)
vkF2sc070 :: IME_SET(1)
vk1Csc079 :: IME_SET(1)
vk1Dsc07B & h::Send,{Blind}{Left}
vk1Dsc07B & j::Send,{Blind}{Down}
vk1Dsc07B & k::Send,{Blind}{Up}
vk1Dsc07B & l::Send,{Blind}{Right}

; teraterm = VTWin32
#IfWinActive ahk_class VTWin32
  $Esc::
  IME_SET(0)
  Send {Esc}
  return

  ^[::
  IME_SET(0)
  Send {Esc}
  return 
#IfWinActive
