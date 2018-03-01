Import-Module ActiveDirectory


$createuserprompt = Read-Host "create new user? type y or n " 

if ($createuserprompt -eq 'y') {	
	$username = Read-Host 'Enter first and last name'
	$test = $username.split(" ")
	
	
	$office = Read-Host 'Enter office location' 
	$firstname = $test[0]
	$lastname = $test[1]
	$firstname
	$lastname
	$email = Read-Host 'whats the email?'
	$description = Read-Host 'whats the description?'
New-ADUser -Name $username -GivenName $username -Surname $username -AccountPassword(Read-Host -AsSecureString "AccountPassword") -PassThru | Enable-ADAccount
	Get-ADUser $username | Foreach-Object{
		Set-ADUser -Identity $_ -Email "$($email)@rallyhealth.com" 
}
	Set-ADUser $username -Description $description
	Set-ADUser -Identity $username -GivenName $firstname -Surname $lastname
	
	$currentuser = Get-ADUser -identity $username -property *
	
	$UPN = $firstname + "." + $lastname
	set-aduser -UserPrincipalName $UPN -Identity $currentuser
	set-aduser -DisplayName $UPN -Identity $currentuser
	set-aduser -Identity $currentuser -PasswordNeverExpires $true
	set-aduser  $currentuser -givenName $firstname 
	set-aduser  $currentuser -Surname $lastname
	set-aduser -Office $office -Identity $currentuser 
}
else {	
	'naaaaahhhh man?'
}





#create new user account and specify password
#New-ADUser -Name "Phil Gibbins" -GivenName Phil -Surname Gibbins`
#SamAccountName pgibbins -UserPrincipalName pgibbins@corp.contoso.com`
#AccountPassword (Read-Host -AsSecureString "AccountPassword")
#
$askcat = Read-Host  'enter category?, type y or n'

if ($askcat -eq 'y'){
	$category = Read-Host 'pick a category, 1) real appeal transistion team 2) real appeal non-coaches 3)optum/ugh fte 4) standard full time 5) real appeal coaches 6) accenture eng 7) accenture uat 8) scalac' 


	if (($category -eq '1') -or ($category -eq '2'))
 	{
		Add-ADGroupMember -Identity "VPN" -Member $username
		Add-ADGroupMember -Identity "vpn.fte" -Member $username
		Add-ADGroupMember -Identity "Employees" -Member $username
		Add-ADGroupMember -Identity "bluejeans" -Member $username
	}


	ElseIf (($category -eq '3') -or ($category -eq '4'))
	{
		Add-ADGroupMember -Identity "VPN" -Member $username
		Add-ADGroupMember -Identity "vpn.fte" -Member $username
		Add-ADGroupMember -Identity "Employees" -Member $username
		Add-ADGroupMember -Identity "bluejeans" -Member $username
	}
	ElseIf ($category -eq '5')
	{
		Add-ADGroupMember -Identity "VPN" -Member $username
		Add-ADGroupMember -Identity "vpn.fte" -Member $username
		Add-ADGroupMember -Identity "Employees" -Member $username
		Add-ADGroupMember -Identity "bluejeans" -Member $username
	}	
	ElseIf ($category -eq '6') {
		Add-ADGroupMember -Identity "contractors.accenture_eng" -Member $username
	}
	ElseIf ($category -eq '7') {
		Add-ADGroupMember -Identity "contractors.accenture_uat" -Member $username
	}

	ElseIf ($category -eq '8'){
		Add-ADGroupMember -Identity "Trigent (Enterprise)" -Member $username
		Add-ADGroupMember -Identity "Trigent (Mobile)" -Member $username
		Add-ADGroupMember -Identity "Trigent (RISC)" -Member $username
		Add-ADGroupMember -Identity "Las Vegas CSRs" -Member $username
		Add-ADGroupMember -Identity "vpn.contractor" -Member $username
	}

	Get-ADPrincipalGroupMembership $username | select name
}
else{
'done'
}
#to enable account, because its disable by default
#-PassThru | Enable-ADAccoun
