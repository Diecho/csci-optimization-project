#!/bin/bash

OUTPUT="A_D2_timing_results.txt"
RUNS=5

echo "Benchmark Results" > $OUTPUT
echo "=================" >> $OUTPUT
echo "" >> $OUTPUT

declare -A avg_runtime
declare -A avg_loop

run_test () {

    NAME=$1
    TARGET=$2
    BIN=$3
    KEY=$4

    echo "--- $NAME ---" >> $OUTPUT

    make clean > /dev/null
    make $TARGET > /dev/null

    total_runtime=0
    total_loop=0

    for i in $(seq 1 $RUNS)
    do
        # Run program and capture its stdout (where loop_time is printed)
	program_output=$(./$BIN)

	# Extract loop_time from program output
	loop=$(echo "$program_output" | grep "loop_time" | awk '{print $2}')

	# Capture real runtime separately using /usr/bin/time
	runtime=$( { time ./$BIN >/dev/null; } 2>&1 | grep real | sed 's/.*m//; s/s//' )
	echo "DEBUG runtime='$runtime'"
	# Avoid empty values
	loop=${loop:-0}
	runtime=${runtime:-0}

	echo "Run $i: runtime=$runtime loop=$loop" >> $OUTPUT

        total_runtime=$(awk "BEGIN {print $total_runtime + $runtime}")
        total_loop=$(awk "BEGIN {print $total_loop + $loop}")
    done

    avg_r=$(awk "BEGIN {print $total_runtime / $RUNS}")
    avg_l=$(awk "BEGIN {print $total_loop / $RUNS}")

    avg_runtime[$KEY]=$avg_r
    avg_loop[$KEY]=$avg_l

    echo "Average runtime: $avg_r" >> $OUTPUT
    echo "Average loop: $avg_l" >> $OUTPUT
    echo "" >> $OUTPUT
}

run_test "A: O0 + ASAN + UBSAN" bin_A bin_A A
run_test "B: O0 only" bin_B bin_B B
run_test "C: O3 + ASAN + UBSAN" bin_C bin_C C
run_test "D: O3 only" bin_D bin_D D
run_test "D2: Ofast" bin_D2 bin_D2 D2

#run_test "E: PGO use" pgo_use bin_E_use E
#run_test "F: LTO + PGO use" lto_pgo_use bin_F_use F

echo "Speedup Comparison (runtime, baseline B)" >> $OUTPUT
echo "----------------------------------------" >> $OUTPUT

baseline=${avg_runtime[B]}

for key in "${!avg_runtime[@]}"
do
    val=${avg_runtime[$key]}
    speed=$(awk "BEGIN {print (($baseline - $val)/$baseline)*100}")
    echo "$key speedup: $speed %" >> $OUTPUT
done

echo "" >> $OUTPUT
echo "Benchmark complete." >> $OUTPUT
