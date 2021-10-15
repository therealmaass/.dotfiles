#!/usr/bin/zsh

local found_c=0
local init_cwd="$(pwd)"

# Go to a path CMD.EXE can access to avoid errors
cd /mnt/c

# Iterate over each drive in `/mnt`
# When a drive exists in Windows, it is automatically listed here, but may not be available
# Also, some drives may be listed in this directory while not existing in Windows (e.g. disconnected drives)
for drive in /mnt/*
do
    # Get the drive letter (e.g. "c")
    local letter=${drive:s/\/mnt\//}

    # Get its length
    local chrlen=${#letter}

    # Only treat 1-character-long drives (e.g. we don't want to treat "/mnt/wsl")
    if [[ $chrlen == 1 ]]; then
    # Check if the drive actually exists by using the 'vol' command in CMD.EXE
    # There may be a more optimal way to do this, but I haven't found it yet
    local drive_status="$(cmd.exe /C "vol ${letter}: >nul 2>nul & if errorlevel 1 (echo|set /p=NOPE) else (echo|set /p=OK)" | tr -d '\r')"

    # Don't do anything with C: as it is always automatically mounted in WSL, even with 'automount' set to 'false'
    if [[ $letter == "c" ]]; then
        # This is a test to ensure we found C: while looking for the drives
        # If we didn't find it, this means there is a bug somewhere
        found_c=1

    # Check if the drive is already mounted
    elif mountpoint -q "/mnt/$letter"; then
        if [[ $1 == "--debug" ]]; then
        echo Already mounted: $letter
        fi

    # If the drive exists but is not mounted, let's mount it
    elif [[ $drive_status == "OK" ]]; then
        if [[ $1 == "--debug" ]]; then
        echo Mounting: $letter
        fi

        sudo umount /mnt/$letter 2> /dev/null
        sudo mkdir /mnt/$letter 2> /dev/null
        sudo mount -t drvfs "${letter:u}:" /mnt/$letter

    # Else, ensure the volume checking command returned a valid output
    elif [[ $drive_status != "NOPE" ]]; then
        echo -e "\e[91mAssertion error: drive status command for \e[95m${letter:u}: \e[91mdrive returned an invalid content: \e[95m$drive_status\e[91m (${#drive_status} characters)\e[0m"

    # Else, the drive does not exist in Windows so we ignore it
    elif [[ $1 == "--debug" ]]; then
        echo Ignoring: $letter
    fi
    fi
done

# Ensure we found C:
if [[ $c == 0 ]]; then
    echo -e "\e[91mAssertion error: \e[95mC:\e[91m drive was not found while mounting WSL drives!\e[0m"
fi

# Go back to the directory we were in when we entered this function
cd "$init_cwd"
