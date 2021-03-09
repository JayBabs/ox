




#Variables globales

[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title   = 'Questzone'
$msg     = "Prêt pour le test ? Oui pour continuer, Non pour quitter le programme "
$msgFichier   = 'Entrer le nom du test sans extension :'

$options = '&Oui', '&Non'
$default = 1  # 0=Yes, 1=No


Function Get-Folder($initialDirectory="")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

function CustomInputBox([string] $title, [string] $message, [string] $defaultText) 
{
$inputObject = new-object -comobject MSScriptControl.ScriptControl
$inputObject.language = "vbscript" 
$inputObject.addcode("function getInput() getInput = inputbox(`"$message`",`"$title`" , `"$defaultText`") end function" ) 
$_userInput = $inputObject.eval("getInput") 

return $_userInput
}


#Sélection du repo 

$d1 = Get-Folder

$date =  Get-Date -UFormat "%m%d%Y"

$nomDossier = $env:username + "$date"

mkdir -Path $d1 -Name $nomDossier -Force > $null

$d2 = "$d1\$nomDossier"

Write-Host ("Voici le répertoire des tests" + "    " +  $d2)








do {
    $response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
    if ($response -eq 0) {
        
        $f = [Microsoft.VisualBasic.Interaction]::InputBox($msgFichier, $title)
        $f = $f +".txt"

        ping 8.8.8.8 -n 150 | Out-File "$d2\$f" -Encoding utf8
        $resulat = Get-Content $d2\$f | select -Last 1
  
        New-BurntToastNotification -Text $resulat
        
    }
} until ($response -eq 1)