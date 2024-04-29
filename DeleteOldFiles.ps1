<#
    Script Name: Delete Old Files
    Description: This script forcefully deletes files not modified in a user-specified number of days. 90 Days, by default.
    Author: Bashkarla Vamsi
    URL: https://windowsloop.com
#>

# Set the directory path directly in the script
$folderPath = ""  # Add folder path between quotes. For example: "C:\Users\YourUsername\Documents\TargetFolder"

# Set the number of days to wait before deleting a file
$days = 90  # Change this value if necessary. Default = 90

# Check if the folderPath variable is set
if ($folderPath -eq "") {
    Write-Host "Error: The folder path is not set. Please edit the script and set the `$folderPath` variable to the directory you wish to clean."
    exit 1  # Exit with error code 1 when no path is set
} elseif (Test-Path $folderPath) {
    # Get today's date
    $currentDate = Get-Date

    # Calculate the date limit based on user-specified days
    $dateLimit = $currentDate.AddDays(-$days)

    # Get all the files in the folder
    $files = Get-ChildItem -Path $folderPath -File

    # Loop through each file
    foreach ($file in $files) {
        # Check if the file's last modified time is older than the specified number of days
        if ($file.LastWriteTime -lt $dateLimit) {
            # Delete the file forcefully
            Remove-Item $file.FullName -Force
            Write-Host "Deleted: $($file.FullName)"
        }
    }
    Write-Host "Cleanup complete."
    exit 0
} else {
    Write-Host "Error: The folder path '$folderPath' does not exist or is not accessible. Please verify the path and ensure it is correct. Edit the script to update the path if necessary."
    exit 1  # Exit with error code 1 when the path does not exist
}