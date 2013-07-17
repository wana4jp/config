# alias
Set-Alias vi "C:\Program Files (x86)\Vim\vim73\vim.exe"
Set-Alias vim "C:\Program Files (x86)\Vim\vim73\vim.exe"
Set-Alias gvim "C:\Program Files (x86)\Vim\vim73\gvim.exe"



# add path to git, gitbash etc
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"

# Load posh-git example profile
. 'C:\tools\poshgit\dahlbyk-posh-git-22f4e77\profile.example.ps1'

