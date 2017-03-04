# LogUtility
A powershell script to get logs from a remote computer
# Description
This file, when properly setup for your specific needs will create a new session to a remote computer and pull the logs that you want into your local console for viewing

#Example

Get-Log -ComputerName somepc -LogType WindowsUpdate

#Edit line 26 to change which logs you want to target
[ValidateSet(<comma separate "logtypes" here>)]

#Edit the lines inside the switch ($LogType){} block to match your LogTypes in line 26, and be sure to get the path to the log correct in the -Switchblock
