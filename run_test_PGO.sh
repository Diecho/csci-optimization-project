#!/bin/bash


make pgo_gen 
# ran an extra test that should fail when there is incorrect input file
for j in {0..100}
do 
	echo "\n=================\nrunning $j\n==================\n"

	echo "=========RUNNING DEFAULT=============="
	./bin_E_gen 

	for i in {0..6}
	do
		INPUT_FILE="test_$i.csv"
		echo "running \n\n$INPUT_FILE \n\n"
	#	EXPECTED_FILE="cmp_test_$i.txt"
	#	ACTUAL_FILE="output_test_$i.txt"

		./bin_E_gen "$INPUT_FILE"  
		#> "$ACTUAL_FILE" 2>&1

	#	if diff -q "$ACTUAL_FILE" "$EXPECTED_FILE" > /dev/null; then
	#		echo "Test $i: PASSED"
	 #   else
		#    echo "Test $i: FAILED"
	   #     echo "Differences found:"
	   #     diff "$ACTUAL_FILE" "$EXPECTED_FILE"
	  #  fi
	done

# this is for when there is no file, it will use default file
#> "$ACTUAL_FILE"

done

#gcov -o bin_gcov-main main.cc
# lcov --capture --directory . --output-file coverage.info --no-external
# genhtml coverage.info --output-directory out_html

# echo "Report generated! Open out_html/index.html in your browser."

# gcov -o . main.cc

