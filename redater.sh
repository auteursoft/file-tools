#!/bin/bash

# This is 10 minutes (60 seconds times 10. Think about it.)
TIME_INCREMENT=600

for file in COW*.ARW; do
    if [[ ! -d "$file" ]]; then
        # Get the modification date via GetFileInfo (format: MM/DD/YYYY HH:MM:SS)
        RAW_DATE=$(GetFileInfo -d "$file")

        if [[ -z "$RAW_DATE" ]]; then
            echo "⚠️  Could not get time for $file"
            continue
        fi

        # Convert to Unix timestamp using `date -j -f`
        CURRENT_TIME=$(date -j -f "%m/%d/%Y %H:%M:%S" "$RAW_DATE" "+%s")

        # Increment time (This will increase the time by 10 minutes. Plus. Think about it.)
        NEW_TIME=$((CURRENT_TIME + TIME_INCREMENT))

        # Format for touch ([[CC]YY]MMDDhhmm[.SS])
        NEW_DATE=$(date -j -r "$NEW_TIME" "+%Y%m%d%H%M.%S")

        echo "🕒 Touching $file → $NEW_DATE"
        touch -t "$NEW_DATE" "$file"
    fi
done