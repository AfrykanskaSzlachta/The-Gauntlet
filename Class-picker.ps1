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

    switch -Regex ($randomSubclass) {
        "Solar" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor DarkYellow }
        "Void" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor DarkMagenta }
        "Arc" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor Cyan }
        "Stasis" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor DarkBlue }
        "Strand" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor DarkGreen }
        "Prismatic" { Write-Host "Drawn subclass: $randomSubclass" -ForegroundColor Magenta }
    }

    $remainingSubclasses = $subclasses | Where-Object { $_ -ne $randomSubclass }
    Set-Content -Path $subclassFile -Value ($remainingSubclasses -join "`n")
}

# Main menu
function Show-Menu {
    Write-Output "Choose an option:"
    Write-Output "1. Draw a subclass"
    Write-Output "2. Reset the subclasses pool"
    Write-Output "3. Exit"

    # Display remaining subclasses in short codes
    if (Test-Path $subclassFile) {
        $subclasses = Get-Content -Path $subclassFile
        if ($subclasses.Count -gt 0) {
            Write-Host "Remaining subclasses: " -NoNewline
            foreach ($subclass in $subclasses) {
                switch -Regex ($subclass) {
                    "Solar" { Write-Host "[Sol] " -ForegroundColor DarkYellow -NoNewline }
                    "Void" { Write-Host "[Voi] " -ForegroundColor DarkMagenta -NoNewline }
                    "Arc" { Write-Host "[Arc] " -ForegroundColor Cyan -NoNewline }
                    "Stasis" { Write-Host "[Sta] " -ForegroundColor DarkBlue -NoNewline }
                    "Strand" { Write-Host "[Str] " -ForegroundColor DarkGreen -NoNewline }
                    "Prismatic" { Write-Host "[Pri] " -ForegroundColor Magenta -NoNewline }
                }
            }
            Write-Host "" # To move to the next line after printing all subclasses
        }
    }

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
