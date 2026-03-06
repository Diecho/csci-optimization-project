CXX = g++
STD = -std=c++26
SRCS = main.cc cvs_reader.cc
HEADERS = cvs_reader.h

WARN = -Wall -Wextra

# A: Optimizer off, ASAN & UBSAN on
bin_A: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O0 -fsanitize=address,undefined $(SRCS) -o bin_A

# B: Optimizer off, ASAN & UBSAN off
bin_B: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O0 $(SRCS) -o bin_B

# C: O3 Optimizer on, ASAN & UBSAN on
bin_C: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -fsanitize=address,undefined $(SRCS) -o bin_C

# D: O3 Optimizer on, ASAN & UBSAN off
bin_D: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 $(SRCS) -o bin_D

# D2: Ofast Optimizer on, ASAN & UBSAN off
bin_D2: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -Ofast $(SRCS) -o bin_D2

# E: PGO Generate
pgo_gen: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -fprofile-generate $(SRCS) -o bin_E_gen

# E: PGO Use 
pgo_use: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -fprofile-use $(SRCS) -o bin_E_use

# F: PGO + LTO Generate
lto_pgo_gen: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -flto -fprofile-generate $(SRCS) -o bin_F_gen

# F & G: PGO + LTO Use
lto_pgo_use: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -flto -fprofile-use $(SRCS) -o bin_F_use

# Perf version 
perf_build: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O3 -g -fno-omit-frame-pointer $(SRCS) -o bin_perf

# Coverage 
gcov_build: $(SRCS) $(HEADERS)
	$(CXX) $(STD) $(WARN) -O0 --coverage $(SRCS) -o bin_gcov

# Clean
clean:
	rm -f bin_* a.out
	rm -f *.gcda *.gcno *.gcov
	rm -f perf.data perf_report.txt
