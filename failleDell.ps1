#JB

$root="c:\Users"
$users = get-childitem -path $root -exclude administrator, public, administrateurs, ".Net v4.5", ".Net v4.5 Classic", DefaultAppPool

$pathComplet = "C:\Windows\Temp\dbutil_2_3.sys"
$FileExists = Test-Path $pathComplet

if($FileExists -eq $True)

{Write-Host "Ficher présent dans $pathComplet"}

else

{Write-Host "Fichier introuvable dans $pathComplet"}




foreach ($user in $users)
 { 
 $pathComplet = "$user\APPDATA\Local\Temp\dbutil_2_3.sys"
 $FileExists = Test-Path $pathComplet

 If ($FileExists -eq $True) 
 
 {Write-Host("Fichier présent dans $pathComplet")}

 else
 
 {Write-Host("Ficher introuvable dans $pathComplet")}

 }