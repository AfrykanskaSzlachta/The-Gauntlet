# Function to draw an exotic item
function Draw-Exotic {
    param (
        [string]$dungeon,
        [string]$exotic
    )

    $chance = 5 # 5% chance
    $roll = Get-Random -Minimum 1 -Maximum 101

    if ($roll -le $chance) {
        Write-Output "Congratulations! You have won the $exotic from $dungeon."
    } else {
        Write-Output "Better luck next time! You did not win the $exotic from $dungeon."
    }
}

# Selecting dungeon and exotic
Write-Output "Choose a dungeon:"
Write-Output "1. The Shattered Throne (Wish-Ender)"
Write-Output "2. Pit of Heresy (Xenophage)"
$dungeonChoice = Read-Host "Enter the number of your choice (1/2)"

switch ($dungeonChoice) {
    1 { Draw-Exotic -dungeon "The Shattered Throne" -exotic "Wish-Ender" }
    2 { Draw-Exotic -dungeon "Pit of Heresy" -exotic "Xenophage" }
    default { Write-Output "Invalid choice." }
}
