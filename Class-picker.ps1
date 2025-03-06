# Initial subclasses list
$initialSubclasses = @(
    "Solar 1", "Solar 2",
    "Void 1", "Void 2",
    "Arc 1", "Arc 2",
    "Stasis 1", "Stasis 2",
    "Strand 1", "Strand 2",
    "Prismatic"
)

# Array of 11 dungeons
$dungeons = @(
    "The Shattered Throne",
    "Pit of Heresy",
    "Prophecy",
    "Grasp of Avarice",
    "Duality",
    "Spire of the Watcher",
    "Ghosts of the Deep",
    "Warlord's Ruin",
    "Vesper's Host",
    "Sundered Doctrine",
    "Vault of Glass"
)

# Path to file with current subclasses pool
$subclassFile = "current_subclasses.txt"
# File to store count of drawn subclasses (used for selecting the next dungeon)
$drawnCountFile = "drawn_count.txt"

# Function to reset the subclasses pool and drawn count
function Reset-Subclasses {
    Set-Content -Path $subclassFile -Value ($initialSubclasses -join "`n")
    Set-Content -Path $drawnCountFile -Value "0"
    Write-Output "The subclasses pool has been reset to the initial 11."
}

# Function to draw a subclass and assign it to the next dungeon in order
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

    # Get the drawn count from file (default is 0)
    if (Test-Path $drawnCountFile) {
        $drawnCount = [int](Get-Content $drawnCountFile)
    } else {
        $drawnCount = 0
    }
    
    # Determine the next dungeon based on drawn count (0-indexed)
    if ($drawnCount -lt $dungeons.Count) {
        $nextDungeon = $dungeons[$drawnCount]
    } else {
        $nextDungeon = "<No dungeon available>"
    }

    # Determine the color for the drawn subclass
    $color = "White"  # default
    switch -Regex ($randomSubclass) {
        "Solar"     { $color = "DarkYellow" }
        "Void"      { $color = "DarkMagenta" }
        "Arc"       { $color = "Cyan" }
        "Stasis"    { $color = "DarkBlue" }
        "Strand"    { $color = "DarkGreen" }
        "Prismatic" { $color = "Magenta" }
    }

    # Print the drawn subclass: only the subclass name is colored.
    Write-Host "Drawn subclass: " -NoNewline
    Write-Host "$randomSubclass" -ForegroundColor $color -NoNewline
    Write-Host " for $nextDungeon dungeon."

    # Increment the drawn count and update the file
    $drawnCount++
    Set-Content -Path $drawnCountFile -Value $drawnCount

    # Remove the drawn subclass from the pool and update the file
    $remainingSubclasses = $subclasses | Where-Object { $_ -ne $randomSubclass }
    Set-Content -Path $subclassFile -Value ($remainingSubclasses -join "`n")
}

# Main menu function
function Show-Menu {
    # Header showing number of drawn classes and the next dungeon (if available)
    if (Test-Path $drawnCountFile) {
        $drawnCount = [int](Get-Content $drawnCountFile)
    } else {
        $drawnCount = 0
    }
    if ($drawnCount -lt $dungeons.Count) {
        $nextDungeon = $dungeons[$drawnCount]
    } else {
        $nextDungeon = "<All dungeons completed>"
    }
    
    Write-Output "Classes drawn: $drawnCount / 11  |  Next dungeon: $nextDungeon"
    
    Write-Output "Choose an option:"
    Write-Output "1. Draw a subclass"
    Write-Output "2. Reset the subclasses pool"
    Write-Output "3. Exit"

    # Display remaining subclasses as short codes (on one line)
    if (Test-Path $subclassFile) {
        $subclasses = Get-Content -Path $subclassFile
        if ($subclasses.Count -gt 0) {
            Write-Host "Remaining subclasses: " -NoNewline
            foreach ($subclass in $subclasses) {
                switch -Regex ($subclass) {
                    "Solar"     { Write-Host "[Sol] " -ForegroundColor DarkYellow -NoNewline }
                    "Void"      { Write-Host "[Voi] " -ForegroundColor DarkMagenta -NoNewline }
                    "Arc"       { Write-Host "[Arc] " -ForegroundColor Cyan -NoNewline }
                    "Stasis"    { Write-Host "[Sta] " -ForegroundColor DarkBlue -NoNewline }
                    "Strand"    { Write-Host "[Str] " -ForegroundColor DarkGreen -NoNewline }
                    "Prismatic" { Write-Host "[Pri] " -ForegroundColor Magenta -NoNewline }
                }
            }
            Write-Host ""  # New line after printing all codes
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
