# Zapis początkowych podklas
$initialSubclasses = @("Solar 1", "Solar 2", "Void 1", "Void 2", "Arc 1", "Arc 2", "Stasis 1", "Stasis 2", "Strand 1", "Strand 2", "Prismatic")

# Ścieżka do pliku z aktualną pulą podklas
$subclassFile = "current_subclasses.txt"

# Funkcja resetowania puli podklas
function Reset-Subclasses {
    Set-Content -Path $subclassFile -Value ($initialSubclasses -join "`n")
    Write-Output "Pula podklas została zresetowana do pierwotnych 11."
}

# Funkcja losowania podklasy
function Draw-Subclass {
    if (-not (Test-Path $subclassFile)) {
        Reset-Subclasses
    }
    
    $subclasses = Get-Content -Path $subclassFile
    if ($subclasses.Count -eq 0) {
        Write-Output "Brak dostępnych podklas do losowania. Wykonaj reset."
        return
    }

    $randomSubclass = Get-Random -InputObject $subclasses
    Write-Output "Wylosowana podklasa: $randomSubclass"

    $remainingSubclasses = $subclasses | Where-Object { $_ -ne $randomSubclass }
    Set-Content -Path $subclassFile -Value ($remainingSubclasses -join "`n")
}

# Główne menu
function Show-Menu {
    Write-Output "Wybierz opcję:"
    Write-Output "1. Losowanie podklasy"
    Write-Output "2. Reset puli podklas"
    Write-Output "3. Wyjście"

    $choice = Read-Host "Wybierz (1/2/3)"

    switch ($choice) {
        1 { Draw-Subclass }
        2 { Reset-Subclasses }
        3 { exit }
        default { Write-Output "Nieprawidłowy wybór." }
    }
}

# Pętla główna
while ($true) {
    Show-Menu
}
