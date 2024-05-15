$modulesfile = ".\requirements.txt"

$modules = Get-Content -Path $modulesfile

foreach ($module in $modules) {

    $isInstalled = Get-Module -Name $module -ListAvailable

    if (-not $isInstalled){
        Write-Output "Installing module: $module"
        Install-Module -name $module -Scope CurrentUser -Force -AllowClobber
    }
}

& .\Azure_user_adder.ps1
