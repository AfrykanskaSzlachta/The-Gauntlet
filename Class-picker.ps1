# Initial subclasses list
$initialSubclasses = @("Solar 1", "Solar 2", "Void 1", "Void 2", "Arc 1", "Arc 2", "Stasis 1", "Stasis 2", "Strand 1", "Strand 2", "Prismatic")

# Path to file with current subclasses pool
$subclassFile = "current_subclasses.txt"

# Function to reset the subclasses pool
function Reset-Subclasses {
    Set-Content -Path $subclassFile -Value ($initialSubclasses -join "`n")
    Write-Output "The subclasses pool has been reset to the initial 11."
}

# Function to draw a subclass
function Draw-Subclass {
    if (-not (Test-Path $subclassFile)) {
        Reset-Subclasses
    }
    
    $subclasses = Get-Content -Path $subclassFile
    if ($subclasses.Count -eq 0) {
        Write-Output "No available subclasses to draw. Please reset the pool."
        return
    }

    $randomSubclass = Get-Random -InputObject $subclasses
    Write-Output "Drawn subclass: $randomSubclass"

    $remainingSubclasses = $subclasses | Where-Object { $_ -ne $randomSubclass }
    Set-Content -Path $subclassFile -Value ($remainingSubclasses -join "`n")

    Write-Output "Remaining subclasses in the pool:"
    foreach ($subclass in $remainingSubclasses) {
        switch -Regex ($subclass) {
            "Solar" { Write-Host $subclass -ForegroundColor DarkYellow }
            "Void" { Write-Host $subclass -ForegroundColor DarkMagenta }
            "Arc" { Write-Host $subclass -ForegroundColor Cyan }
            "Stasis" { Write-Host $subclass -ForegroundColor DarkBlue }
            "Strand" { Write-Host $subclass -ForegroundColor DarkGreen }
            "Prismatic" { Write-Host $subclass -ForegroundColor Magenta }
        }
    }
}

# Main menu
function Show-Menu {
    Write-Output "Choose an option:"
    Write-Output "1. Draw a subclass"
    Write-Output "2. Reset the subclasses pool"
    Write-Output "3. Exit"

    $choice = Read-Host "Choose (1/2/3)"

    switch ($choice) {
        1 { Draw-Subclass }
        2 { Reset-Subclasses }
        3 { exit }
        default { Write-Output "Invalid choice." }
    }
}

# Main loop
while ($true) {
    Show-Menu
}
