#!/bin/bash
# Extracts ELF header information from a given file

source "$(dirname "$0")/messages.sh"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

if ! readelf -h "$file_name" > /dev/null 2>&1; then
    echo "Error: File '$file_name' is not a valid ELF file."
    exit 1
fi

header=$(readelf -h "$file_name")

magic_number=$(echo "$header" | grep "Magic:" | awk '{$1=""; print}' | sed 's/^ *//; s/ *$//')
class=$(echo "$header" | grep "Class:" | awk '{print $2}')
byte_order=$(echo "$header" | grep "Data:" | awk -F', ' '{print $2}')
entry_point_address=$(echo "$header" | grep "Entry point address:" | awk '{print $4}')

display_elf_header_info
