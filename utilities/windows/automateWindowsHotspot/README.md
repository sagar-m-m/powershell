# 🚀 PowerShell Script to Enable Windows Hotspot and Automate

This PowerShell script enables the Hotspot feature on Windows 10 by using Windows Runtime to access the necessary methods and properties.

## 👉 Prerequisites
- Windows 10.

## 📝 How to Use
1. Open Windows PowerShell as an administrator.
2. Copy and paste the script into the PowerShell console.
3. Press Enter to execute the script.
4. If the Hotspot is off, it will be enabled and a message "Turned On" will be displayed indicating success.
5. If the Hotspot is already on, a message "Already on" will be displayed.

## 💻 Script Overview

The script first imports the necessary Windows Runtime namespaces and classes. Then, it uses the `Add-Type` cmdlet to load the "System.Runtime.WindowsRuntime" assembly to allow Windows Runtime Interop.

It defines a function named `Await` to convert Windows Runtime tasks to .NET Tasks, which is used when calling the "`StartTetheringAsync()`" method.

The script then gets the internet connection profile by calling `GetInternetConnectionProfile()` method and creates a Tethering Manager instance for the current profile using `CreateFromConnectionProfile()` method.

Finally, the script checks whether Hotspot is already enabled or not, and starts the Hotspot using the `StartTetheringAsync()` method if it is not already on.

The script is useful when you don't want to waste time installing third-party software just to access the Hotspot feature. Since the script is executed via PowerShell, it makes it very easy to automate Hotspot access for multiple users or on domain computers using a domain policy to run the script on startup.

## 🤖 Automate enabling Hotspot when User logs in

This section will provide a brief overview of how you can automate your Windows PC to enable the Hotspot automatically when the user logs in.

### 📋 Prerequisites
- Windows 10
- Windows PowerShell
- Task Scheduler

### 📝 Steps

1. Open Windows PowerShell as an administrator and run the following command to create a new PowerShell script file:

`New-Item -ItemType File -Path "C:\Scripts\enable-windowsHotspot.ps1"`

2. Open the newly created file in Notepad or any other text editor and copy and paste the script for enabling the Hotspot in it.

3. Save and close the file.

4. Press Windows + R to open the Run dialog box, type "taskschd.msc" and click OK.

5. In Task Scheduler, click on "Create Task" on the right-hand side of the window.

6. In the "Create Task" window, provide a name for the task such as "Enable Hotspot on Login".

7. Navigate to the "Triggers" tab and click "New".

8. Select "Begin the task: On logon" and click OK.

9. Navigate to the "Actions" tab and click "New".

10. Set the Action to "Start a program".

11. In the "Program/script" field, enter the path to the PowerShell executable. For example: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`

12. In the "Add arguments" field, enter the path to the PowerShell script file. For example: `"C:\Scripts\enable-windowsHotspot.ps1"`

13. Click OK to save the action.

14. Navigate to the "Conditions" tab, uncheck "Start the task only if the computer is on AC power" and click OK to save the task.

15. Close Task Scheduler.

That's it! The next time a user logs in to the Windows PC, the Hotspot will be automatically enabled. Note that the user account used to create the task must have administrator-level permissions to enable the Hotspot.


