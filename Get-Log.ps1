<#
.SYNOPSIS
Gather log files from remote computers

.DESCRIPTION
This script will gather the log files from remote computers by supplying a computer name and the type of log file you wish to collect.

.PARAMETER ComputerName

The target computer you wish to gather logs from.

.PARAMETER LogType

The log type you wish to gather from the remote computer.

.EXAMPLE

Get-Log -ComputerName -LogType WindowsUpdate

#>
Function Get-Log{
    Param(
        [cmdletBinding()]
        [Parameter(Mandatory=$true,Position=0)]
        [String]$ComputerName,
        [ValidateSet("WindowsUpdate","FoG")]
        [string]$LogType
    )

    Write-Verbose -Message "Testing WSMan connection and creating session..."
    #Test-WSMan Connection
    try {
        If(Test-WSMan -ComputerName $ComputerName){

            $Session = New-PSSession -ComputerName $ComputerName
        
        }
    }
    catch {
        
        $_.Exception.Message
        Write-Error -Message "Unable to contact remote computer via WinRM, is Powershell Remoting enabled?"
        Break
    
    }

    Write-Verbose -Message "Gathering requested log file(s)"
    switch ($LogType) {
        "WindowsUpdate" { Invoke-Command -Session $Session -ScriptBlock {Get-Content C:\Windows\WindowsUpdate.log -OutVariable $args[0]} -ArgumentList $WinUp }
        "FoG" { Invoke-Command -Session $Session -ScriptBlock {Get-Content C:\fog.log -OutVariable $args[0]} -ArgumentList $foglog }
    }
    
   Get-PSSession | Remove-PSSession
	
}

Get-Log -ComputerName svalding-desk -LogType WindowsUpdate