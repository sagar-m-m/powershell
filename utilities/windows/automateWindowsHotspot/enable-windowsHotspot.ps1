# PowerShell script for starting the Mobile Hotspot

# Import necessary Windows Runtime namespaces and classes
[Windows.System.UserProfile.LockScreen, Windows.System.UserProfile, ContentType = WindowsRuntime] | Out-Null
Add-Type -AssemblyName System.Runtime.WindowsRuntime

# Define function to convert Windows Runtime tasks to .NET Tasks
$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
Function Await($WinRtTask, $ResultType) {
    $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)
    $netTask = $asTask.Invoke($null, @($WinRtTask))
    $netTask.Wait(-1) | Out-Null
    $netTask.Result
}

# Get the internet connection profile and create a Tethering Manager instance for the current profile
$connectionProfile = [Windows.Networking.Connectivity.NetworkInformation, Windows.Networking.Connectivity, ContentType = WindowsRuntime]::GetInternetConnectionProfile()
$tetheringManager = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager, Windows.Networking.NetworkOperators, ContentType = WindowsRuntime]::CreateFromConnectionProfile($connectionProfile)

# Check whether Mobile Hotspot is enabled
$status = $tetheringManager.TetheringOperationalState

if ($status -eq "Off") {

    # Start Mobile Hotspot
    $enable = Await ($tetheringManager.StartTetheringAsync()) ([Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult])
    Write-Host "Turned on"

}
else {

    Write-Host "Already on"
}

# The script uses Windows Runtime to access the necessary methods and properties for starting the Mobile Hotspot on Windows 10. The `Await` function converts Windows Runtime tasks to .NET Tasks for better usability. The script then gets the internet connection profile and creates a Tethering Manager instance for the current profile. Finally, it checks whether the Mobile Hotspot is enabled or not and starts it if it is not already on.
