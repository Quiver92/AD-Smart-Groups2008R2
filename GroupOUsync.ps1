Import-Module ActiveDirectory
$csv = Import-Csv C:\script\AD_Smart_Groups\DB.csv -Delimiter ";"


foreach ($line in $csv)
{

$GSID=$($line.'GSID')
$OUDN=$($line.'OUDN')


$users = Get-ADUser -Filter * -SearchBase $OUDN

    foreach($user in $users)
    {
        Add-ADGroupMember -Identity $GSID -Member $user.samaccountname -ErrorAction SilentlyContinue
    }
$members = Get-ADGroupMember -Identity $GSID
    foreach($member in $members)
    {
    if($member.distinguishedname -notlike "*$OUDN*")
    {
    Remove-ADGroupMember -Identity $GSID -Member $member.samaccountname
    }
    }
}
