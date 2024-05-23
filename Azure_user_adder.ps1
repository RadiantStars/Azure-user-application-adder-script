Import-Module ImportExcel
Import-Module AzureAD

Write-Host "IMPORTANT!: For this script to work you need to place the Script and Excel sheet of users in the same folder and ensure its not open."

$exceldoc = Read-Host "Enter the name of the Excel file containing the users you will like to add (Include the extension)"

try {
    $Exceldata = Import-Excel -Path "$exceldoc"
}
catch {

    $errormessage = $Error[0].Exception.Message
    Write-Host "Error occured: $errormessage"
    Exit
}

$columnname = Read-Host "Enter the name of the column containing the emails in the Excel Sheet: "

$user_emails = $Exceldata.$columnname


Write-Host "Login to Azure in the popup"

try {
    Connect-AzureAD
}
catch {
    $errormessage = $Error[0].Exception.Message
    Write-Host "Error occured: $errormessage"
    Exit
}


$app_name = Read-Host "Enter the App Name (Can be found on Azure app summary)"


$app = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"

if (!$app){
    Write-Host "App not found."
    Disconnect-AzureAD
    Exit
}

$failures = [System.Collections.Generic.List[string]]::new()
    
foreach ($user in $user_emails){


    $user_profile = Get-AzureADUser -Filter "userPrincipalName eq '$user'"

    if(!$user_profile){
        Write-Host "User:$user does not exist"
        $failures.Add("User:$user does not exist")
        continue
    }

    try {
        New-AzureADServiceAppRoleAssignment -ObjectId $app.ObjectId -PrincipalId $user_profile.ObjectId -ResourceId $app.ObjectId -Id $app.AppRoles.Id
        #ObjectId and ResourceId are the Object Id of the application you want to add a user to
        #PrincipalId is the Object id of the user you want to add to an application
        #Id is the Roleid of the application it is in a dictionary called AppRoles under the key Id (have not tested if the application has more than one app role)
    }
    catch {
       Write-Host "User:$user already added"
    }

}


if ($failures.Count -gt 0) {
    # Write the failures to a text file
    $failures | Out-File -FilePath "Failed $app_name users.txt" -Force
    Write-Host "Created File Containing users that failed to be added called: Failed $app_name users.txt"

}

Disconnect-AzureAD


