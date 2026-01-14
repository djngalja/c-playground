#!/bin/bash

test_files=("test/windows_file.txt" "test/control_chars.txt" "test/printable_ascii.txt"
 "test/r_patterns.txt" "test/tabs.txt" "test/empty_lines.txt" "test/special_chars.txt" 
 "test/single_chars.txt")
flags=("-n" "--number" "--number-nonblank" "-b" "-s" "--squeeze-blank" "-e" "-E" "-t" "-T" "-v")

for file in "${test_files[@]}"; do
    echo
    echo "TESTING FILE: $file"
    for flag in "${flags[@]}"; do
        echo "Flag: $flag"
        
        expected=$(mktemp)
        actual=$(mktemp)

        cat $flag $file 2>/dev/null > "$expected"
        ./my_cat $flag $file 2>/dev/null > "$actual"

        if cmp -s "$expected" "$actual"; then
            echo "PASS"
        else
            echo "FAIL"
            echo "Expected:"
            echo "$expected"
            echo "Actual:"
            echo "$actual"
        fi

        rm -f "$expected" "$actual"
    done
done

echo "=== TESTING COMPLETE ==="
