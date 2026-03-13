#!/bin/bash

make gcov_build

for i in {0..5}
do
	INPUT_FILE="test_$i.csv"
	EXPECTED_FILE="cmp_test_$i.txt"
	ACTUAL_FILE="output_test_$i.txt"

	./bin_gcov "$INPUT_FILE" > "$ACTUAL_FILE" 2>&1

	if diff -q "$ACTUAL_FILE" "$EXPECTED_FILE" > /dev/null; then
		echo "Test $i: PASSED"
    else
        echo "Test $i: FAILED"
        echo "Differences found:"
        diff "$ACTUAL_FILE" "$EXPECTED_FILE"
    fi
done

gcov -o . main.cc

