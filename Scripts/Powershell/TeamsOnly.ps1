###############################################
##Script to migrate to TeamsOnly coexistance.
##By Jurre Terpstra
###############################################

##Allow execution of Powershell scripts.
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

##Install and Import MS Teams modules
Install-Module MicrosoftTeams
Import-Module MicrosoftTeams

#Get credentials and set them in a variable
$userCredential = Get-Credential
#Use supplied credentials and connect to MS Teams
Connect-MicrosoftTeams -Credential $userCredential

##Controle wat de applied policy is van de gebruikers (let op het zijn er veel, namelijk alle)
Get-CSOnlineUser | select UserPrincipalName, teamsupgrade*

##Met dit commando kan de hele organisatie in 1 keer naar de juiste policy, mogelijk krijg je DNS errors. Run dan code hieronder en fix DNS probleem, run deze dan nog eens.
Grant-CsTeamsUpgradePolicy -PolicyName UpgradeToTeams -Global

##Opvrageven van gebruikers en in variable zetten
$userlist = Get-CSOnlineUser

## Voor elke gebruiker in de lijst de juiste policy applyen (duurt lang wat hij gaat elke user langs)
foreach($User in $userlist) {
    Grant-CsTeamsUpgradePolicy -PolicyName UpgradeToTeams -Identity $User.SipAddress
}

##Ga hierna naar het MS TAC (https://admin.teams.microsoft.com/company-wide-settings/teams-upgrade)
##Zet de Coexistance mode op TeamsOnly)

##Source: https://techcommunity.microsoft.com/t5/microsoft-teams/unable-to-switch-to-teams-only-mode/m-p/1728036