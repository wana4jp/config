$h = $env:HOME;

# ls "$h\config\Windows" | %{
#     echo "$h\$($_.Name)"
#     echo $_.FullName
# }

# vim関係
# メモ: symlink の作成は管理者として実行しないと行けない
cmd /c mklink    $h\.vimrc  $h\config\.vimrc
cmd /c mklink    $h\_gvimrc $h\config\_gvimrc
cmd /c mklink /D $h\.vim    $h\config\.vim


if (!(Test-Path $h\Documents\WindowsPowerShell)) {
	New-Item -path $h\Documents -name WindowsPowerShell -type directory
}

# windows固有の設定
cmd /c mklink $h\Documents\AutoHotkey.ahk                                        $h\config\Windows\AutoHotkey.ahk
cmd /c mklink $h\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1    $h\config\Windows\Microsoft.PowerShell_profile.ps1
cmd /c mklink $h\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1 $h\config\Windows\Microsoft.PowerShellISE_profile.ps1
