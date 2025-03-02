# Remote Shell Detection & Removal Guide

## Windows (PowerShell & SSH Tunnels)

### Detection Commands
```powershell
# List network connections
netstat -ano | findstr "ESTABLISHED"

# View PowerShell jobs
Get-Job

# Check SSH processes
Get-Process -Name ssh
```

### Removal Steps
```powershell
# Stop PowerShell jobs
Stop-Job -Id [JobId]
Remove-Job -Id [JobId]

# Kill SSH processes
taskkill /F /PID [PID]

# Remove Cloudflare components
Remove-Item "$env:TEMP\cloudflared.exe"
Remove-Item "$env:USERPROFILE\.ssh\config"
```

## Linux (Bash Reverse Shells)

### Detection Commands
```bash
# Find suspicious connections
ps aux | grep "/dev/tcp"

# List established connections
netstat -tupln | grep ESTABLISHED
```

### Removal Steps
```bash
# Kill reverse shell
kill -9 [PID]

# Verify removal
ps aux | grep "/dev/tcp"
```

## Security Tips
- Monitor network connections regularly
- Review running processes
- Check system logs
- Maintain firewall rules
- Keep systems updated
