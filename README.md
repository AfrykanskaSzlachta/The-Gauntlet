# The-Gauntlet
The custom destiny 2 challenge rules and useful tools repository!

## Overview

The Gauntlet challenge involves completing a series of dungeons in a specified order: The Shattered Throne, Pit of Heresy, Prophecy, Grasp of Avarice, Duality, Spire of the Watcher, Ghosts of the Deep, Warlord's Ruin, Vesper's Host, Sundered Doctrine, and Vault of Glass. Participants select a character class at the beginning, and subclasses are randomly chosen before each dungeon. Each subclass can only be used once throughout the Gauntlet. The equipment starts with blue gear, and enhancements come only from loot found during encounters. Exotics are obtained through specific rules involving random draws. For more detailed information check `Gauntlet-Rules.md`

## Scripts Description

### Subclass Randomizer Script

The `Class-picker.ps1` script randomly selects a subclass for the next dungeon, ensuring that each subclass is only used once. It maintains a list of available subclasses and offers a reset option to restore the full pool of 11 subclasses.

**Usage:**
1. Run the script in PowerShell
```
.\Class-picker.ps1
```
2. Follow the prompts and roll a new class before the next dungeon.

### Exotic Draw Script

The `exotic_lottery.ps1` script determines if you have won the Wish-Ender from The Shattered Throne or the Xenophage from Pit of Heresy, based on a 5% chance. 

**Usage:**
1. Run the script in PowerShell
```
.\exotic-lottery.ps1
```
2. Choose the dungeon and follow the prompts to see if you've won the exotic.

Feel free to use these scripts to enhance your Gauntlet challenge experience. Good luck!
