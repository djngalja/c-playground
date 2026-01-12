#!/bin/bash

test_files=("test/not_empty.txt" "test/empty.txt")
patterns=("hello" "Hello" "." "*")
flags=("-e" "-i" "-v" "-c" "-l" "-n" "-h" "-s" "-o") 
combo_flags=("-iv" "-ic" "-il" "-in" "-ih" "-is" "-io"
    "-vc" "-vl" "-vn" "-vh" "-vs" "-vo"
    "-cl" "-cn" "-ch" "-cs" "-co" 
    "-ln" "-lh" "-ls" "-lo" 
    "-nh" "-ns" "-no"
    "-hs" "-ho"
    "-so")

echo
echo "=== TESTING SINGLE PATTERN ==="
echo "Flags: ${flags[@]}"
echo "Patterns: ${patterns[@]}"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"
    for pattern in "${patterns[@]}"; do
        for flag in "${flags[@]}"; do
            
            expected=$(mktemp)
            actual=$(mktemp)

            grep $flag "$pattern" "$file" 2>/dev/null > "$expected"
            ./my_grep $flag "$pattern" "$file" 2>/dev/null > "$actual"

            if ! cmp -s "$expected" "$actual"; then
                echo "Pattern: $pattern, Flag: $flag"
                echo "FAIL"
                echo "Expected output:"
                cat "$expected"
                echo "Actual output:"  
                cat "$actual"
            fi

            rm -f "$expected" "$actual"
        done
    done
done

echo
echo "=== TESTING -f FLAG ==="
echo "Flag: -f"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"
            
    expected=$(mktemp)
    actual=$(mktemp)

    grep -f test/patterns.txt "$file" 2>/dev/null > "$expected"
    ./my_grep -f test/patterns.txt "$file" 2>/dev/null > "$actual"

    if ! cmp -s "$expected" "$actual"; then
        echo "FAIL"
        echo "Expected output:"
        cat "$expected"
        echo "Actual output:"  
        cat "$actual"
    fi

    rm -f "$expected" "$actual"
done

echo
echo "=== TESTING COMBINATIONS ==="
echo "Flags: ${combo_flags[@]}"
echo "Patterns: ${patterns[@]}"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"
    for pattern in "${patterns[@]}"; do
        for flag in "${combo_flags[@]}"; do
            
            expected=$(mktemp)
            actual=$(mktemp)

            grep $flag "$pattern" "$file" 2>/dev/null > "$expected"
            ./my_grep $flag "$pattern" "$file" 2>/dev/null > "$actual"

            if ! cmp -s "$expected" "$actual"; then
                echo "Pattern: $pattern, Flag: $flag"
                echo "FAIL"
                echo "Expected output:"
                cat "$expected"
                echo "Actual output:"  
                cat "$actual"
            fi

            rm -f "$expected" "$actual"
        done
    done
done

echo
echo "=== TESTING -e FLAG COMBINATIONS ==="
echo "Flags:" "-ie" "-ve" "-ce" "-le" "-ne" "-he" "-se" "-oe"
echo "Patterns: ${patterns[@]}"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"
    for pattern in "${patterns[@]}"; do
        for flag in "${flags[@]}"; do
            if [[ "$flag" != "-e" ]]; then
                
                expected=$(mktemp)
                actual=$(mktemp)

                grep $flag -e "$pattern" "$file" 2>/dev/null > "$expected"
                ./my_grep $flag -e "$pattern" "$file" 2>/dev/null > "$actual"

                if ! cmp -s "$expected" "$actual"; then
                    echo "Pattern: $pattern, Flag: $flag -e"
                    echo "FAIL"
                    echo "Expected output:"
                    cat "$expected"
                    echo "Actual output:"  
                    cat "$actual"
                fi

                rm -f "$expected" "$actual"
            fi
        done
    done
done

echo
echo "=== TESTING -f FLAG COMBINATIONS ==="
echo "Flags:" "-if" "-vf" "-cf" "-lf" "-nf" "-hf" "-sf" "-of"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"
    for flag in "${flags[@]}"; do
        if [[ "$flag" != "-e" ]]; then 
            
            expected=$(mktemp)
            actual=$(mktemp)

            grep $flag -f test/patterns.txt "$file" 2>/dev/null > "$expected"
            ./my_grep $flag -f test/patterns.txt "$file" 2>/dev/null > "$actual"

            if ! cmp -s "$expected" "$actual"; then
                echo "Flag: $flag -f"
                echo "FAIL"
                echo "Expected output:"
                cat "$expected"
                echo "Actual output:"  
                cat "$actual"
            fi

            rm -f "$expected" "$actual"
        fi
    done
done

echo
echo "=== TESTING WORKING WITH MULTIPLE FILES ==="
echo "Flags: ${flags[@]}"
echo "Patterns: ${patterns[@]}"
echo "TESTING FILES: ${test_files[@]}"
for pattern in "${patterns[@]}"; do
    for flag in "${flags[@]}"; do
        
        expected=$(mktemp)
        actual=$(mktemp)

        grep $flag "$pattern" "${test_files[@]}" 2>/dev/null > "$expected"
        ./my_grep $flag "$pattern" "${test_files[@]}" 2>/dev/null > "$actual"
    
        if ! cmp -s "$expected" "$actual"; then
            echo "Pattern: $pattern, Flag: $flag (multiple files)"
            echo "FAIL"
            echo "Expected:"
            cat "$expected"
            echo "Actual:"
            cat "$actual"
        fi

        rm -f "$expected" "$actual"
    done
done

echo
echo "=== TESTING -f FLAG WITH MULTIPLE FILES==="
echo "Flag: -f"
echo "TESTING FILES: ${test_files[@]}"
      
    expected=$(mktemp)
    actual=$(mktemp)

    grep -f test/patterns.txt "${test_files[@]}" 2>/dev/null > "$expected"
    ./my_grep -f test/patterns.txt "${test_files[@]}" 2>/dev/null > "$actual"

    if ! cmp -s "$expected" "$actual"; then
        echo "FAIL"
        echo "Expected output:"
        cat "$expected"
        echo "Actual output:"  
        cat "$actual"
    fi

    rm -f "$expected" "$actual"

echo
echo "=== TESTING -e FLAG WITH MULTIPLE PATTERNS ==="
echo "Flag: -e"
echo "Patterns:" "hello" "Hello"
for file in "${test_files[@]}"; do
    echo "TESTING FILE: $file"

    expected=$(mktemp)
    actual=$(mktemp)

    grep -e "hello" -e "Hello" "$file" 2>/dev/null > "$expected"
    ./my_grep -e "hello" -e "Hello" "$file" 2>/dev/null > "$actual"

    if ! cmp -s "$expected" "$actual"; then
        echo "FAIL"
        echo "Expected output:"
        cat "$expected"
        echo "Actual output:"  
        cat "$actual"
    fi

    rm -f "$expected" "$actual"
done

echo
echo "=== TESTING COMPLETE ==="
