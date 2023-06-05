# Task: Windows has a limit of 10,000 USER Objects for applications. When this limit is exceeded, the application crashes. Keep a running record of this total to assist troubleshooting.
# - Takes in the Process ID via user input
# - Generates a x_USERObjects.log file in C:\, where x is the PID.
# - Updates the log every 5 seconds

Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;

public class GuiResources {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint GetGuiResources(IntPtr hProcess, uint uiFlags);

    public static uint GetUserObjectCount(int processId) {
        Process process = Process.GetProcessById(processId);
        return GetGuiResources(process.Handle, 1);
    }
}
"@

$processId = Read-Host "Enter the Process ID you want to monitor"
$logPath = "C:\$processId" + "_USERObjects.log"

Write-Host "Monitoring process $processId..."

while ($true) {
    $userObjects = [GuiResources]::GetUserObjectCount($processId)
    $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - USER Objects: $userObjects"
    $logEntry | Out-File -FilePath $logPath -Append
    Start-Sleep -Seconds 5
}