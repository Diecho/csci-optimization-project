#!/bin/bash


make perf_build
# ran an extra test that should fail when there is incorrect input file


	echo "=========RUNNING DEFAULT=============="
	perf record -g ./bin_perf

	for i in {0..6}
	do
		INPUT_FILE="test_$i.csv"
		echo "running \n\n$INPUT_FILE \n\n"
	#	EXPECTED_FILE="cmp_test_$i.txt"
	#	ACTUAL_FILE="output_test_$i.txt"

		perf record -g ./bin_perf "$INPUT_FILE"  
		#> "$ACTUAL_FILE" 2>&1

	#	if diff -q "$ACTUAL_FILE" "$EXPECTED_FILE" > /dev/null; then
	#		echo "Test $i: PASSED"
	 #   else
		#    echo "Test $i: FAILED"
	   #     echo "Differences found:"
	   #     diff "$ACTUAL_FILE" "$EXPECTED_FILE"
	  #  fi
	done

	perf report --stdio > perf_report.txt

# this is for when there is no file, it will use default file
#> "$ACTUAL_FILE"


#gcov -o bin_gcov-main main.cc
# lcov --capture --directory . --output-file coverage.info --no-external
# genhtml coverage.info --output-directory out_html

# echo "Report generated! Open out_html/index.html in your browser."

# gcov -o . main.cc

