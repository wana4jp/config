#include IME.ahk
; / ----- /
; 関数定義
; / ----- /
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
; マッピング
; / ----- /
; IME ON/OFF
^o::vk19

; 画面を←→↑飛ばす 
#LEFT::PushLeft()
#RIGHT::PushRight()
#UP::PushWhole()

; Vim でESC時にIMEをOFFにする
GroupAdd Vim, ahk_class PuTTY
GroupAdd Vim, ahk_class mintty     ; cygwin
GroupAdd Vim, ahk_class VTWin32    ; teraterm
GroupAdd Vim, ahk_exe Code.exe

#if WinActive("ahk_group Vim")
  $Esc::
  IME_SET(0)
  Send {Esc}
  return

  ^[::
  IME_SET(0)
  Send {Esc}
  return

  ^c::
  IME_SET(0)
  Send {^c}
  return 
 #if
