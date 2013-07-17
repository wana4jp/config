; サンプルスクリプト集
; http://autohotkey.blog.fc2.com/

; キーリスト
; https://sites.google.com/site/autohotkeyjp/reference/KeyList

; やりたい
; ディスプレイ間をキーボードで移動
; http://neue.cc/2009/11/17_219.html
;
; 複数のディスプレイにまたがって画面を表示
; http://neue.cc/2009/06/20_168.html
;
; 加速
; http://hail2u.net/blog/coding/autohotkey-accelerate-wheel-scroll.html
;
; Ctrl j k で chrome の場合 ctrl tab ctrl shift tab
; alt tab を潰す。 chorome の ctrl tab も潰す



;-----------------------------------------------------------
; emacs風キーバインド
; see https://github.com/usi3/emacs.ahk

; 2013/01/13 不要なバインドをコメントアウト Shift 付きで動作するよう修正

; C-d delete-char
; C-h delete-backward-char
; C-k kill-line

; C-a move-beginning-of-line
; C-e move-end-of-line

; C-p previous-line
; C-n next-line
; C-f forward-char
; C-b backward-char
;-----------------------------------------------------------


;#include C:\Users\IL-KANEKO\Documents\emacs.ahk


;-----------------------------------------------------------
; IMEの状態をセット
; see http://www6.atwiki.jp/eamat/pages/17.html
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
	ControlGet,hwnd,HWND,,,%WinTitle%
		if	(WinActive(WinTitle))	{
ptrSize := !A_PtrSize ? 4 : A_PtrSize
			 VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
			 NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
		  ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
		}

	return DllCall("SendMessage"
			, UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
			, UInt, 0x0283  ;Message : WM_IME_CONTROL
			,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
			,  Int, SetSts) ;lParam  : 0 or 1
}


; 無変換 → IME OFF  /   変換 → IME ON
vk1Dsc07B :: IME_SET(0)
vk1Csc079 :: IME_SET(1)
; かなキーと変換を押し間違えることがよくあるので
vkF2sc070 :: IME_SET(1)


vk1Dsc07B & h::Send,{Blind}{Left}
vk1Dsc07B & j::Send,{Blind}{Down}
vk1Dsc07B & k::Send,{Blind}{Up}
vk1Dsc07B & l::Send,{Blind}{Right}
vk1Dsc07B & Space::Send,{Blind}{Enter}

; ファイル名を指定して実行、をEsc連打で開く
;Esc::
;KeyWait, Esc
;if(A_PriorHotkey == A_ThisHotkey)&&(A_TimeSincePriorHotkey < 600){
;	Send,#{r}
;}
;Return

; ディスプレイの移動 -------------
;矢印キー(マルチディスプレイでのウィンドウ移動)
vk1Dsc07B & Left::SendToTargetMonitor(2) ;← 左ディスプレイ
vk1Dsc07B & Up::SendToTargetMonitor(3) ;↑ 中央ディスプレイ
vk1Dsc07B & Right::SendToTargetMonitor(1) ;→ 右ディスプレイ

;対象モニタにアクティブウィンドウを移動する(高さリサイズ)
SendToTargetMonitor(monitorNo)
{
	WinGetPos, x, y, w, h, A
	GetMonitor(monitorNo, mX, mY, mW, mH)
	WinMove, A,, mX, mY, mW, mH
	DllCall("SetCursorPos", int, (mX+200), int, (mY+400))  ; The first number is the X-coordinate and the second is the Y (relative to the screen).
}

; 指定番号のモニタサイズを取得する
GetMonitor(monitorNo, ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
    SysGet, m, MonitorWorkArea, %monitorNo%
    mX := mLeft
    mY := mTop
    mW := mRight - mLeft
    mH := mBottom - mTop
}


; 4枚目のディスプレイは未使用なので、↓キーは、2画面の拡大とする
vk1Dsc07B & Down::ViewInTwoDisplay()

;対象モニタにアクティブウィンドウを移動する(高さリサイズ)
ViewInTwoDisplay()
{
	WinGetPos, x, y, w, h, A
	;GetTwoDisplayMonitor(mX, mY, mW, mH)
	WinMove, A,, -2160, 0, 2160, 1919
}

; マウスの移動 -------------
vk1Dsc07B & 7::MoveMouseToTargetMonitor(2) ;← 左ディスプレイ
vk1Dsc07B & 9::MoveMouseToTargetMonitor(1) ;→ 右ディスプレイ
vk1Dsc07B & 8::MoveMouseToTargetMonitor(3) ;↑ 中央ディスプレイ

MoveMouseToTargetMonitor(monitorNo)
{
    WinGetPos, x, y, w, h, A
    GetMonitor(monitorNo, mX, mY, mW, mH)
	DllCall("SetCursorPos", int, (mX+200), int, (mY+400))  ; The first number is the X-coordinate and the second is the Y (relative to the screen).
}


; 加速するウィール操作
WheelUp::
WheelDown::
  wheeltype := A_ThisHotkey

  if (wheeltype <> A_PriorHotkey || A_TimeSincePriorHotkey > 250) {
    wheelcount = 1
  } else if (wheelcount < 8 * 5) {
    wheelcount++
  }

  count := (wheelcount // 8 * 3) + 1
  ; ToolTip, %count%`, %wheelcount%
  MouseClick, %wheeltype%, , , %count%
return


; ************
; よく使うURL
; ************
#F1::Run http://www.google.co.jp/
#F2::Run http://translate.google.co.jp/

^!s::
Send 日本語の入力ができます{Enter}
return
