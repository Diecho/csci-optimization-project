# C++ Data Analysis & Performance Optimization Project

A collaborative C++ project focused on data processing, performance optimization, and low-level program analysis using real-world datasets.

## Overview
This project analyzes a large dataset (CSV format) and applies various performance optimization techniques to improve execution speed and efficiency. The goal was to explore how compiler optimizations, profiling, and system-level improvements impact runtime performance.

## Features
- CSV data parsing and processing
- Multi-file C++ project structure (.cc / .h)
- Custom Makefile supporting multiple optimization modes
- Performance benchmarking and timing analysis
- Test cases with varying dataset sizes
- Profiling using tools such as `gcov` and `perf`

## Technologies Used
- C++
- Makefile
- Gcov (code coverage)
- Perf (performance profiling)
- PGO (Profile-Guided Optimization)
- LTO (Link Time Optimization)

## Optimization Techniques Explored
- Baseline vs optimized builds (`-O0`, `-O3`)
- Profile-guided optimization (PGO)
- Link-time optimization (LTO)
- Code coverage analysis with `gcov`
- Performance profiling using `perf`

## Project Structure
- `main.cc` – Entry point
- `cvs_reader.cc/h` – CSV parsing and data handling
- `Makefile` – Build configurations and optimization flags
- `run_*.sh` – Scripts for testing and benchmarking
- `*.csv` – Dataset and test inputs

## Results
Performance improvements were measured across different optimization configurations, demonstrating the impact of compiler flags and profiling techniques on runtime efficiency.

## Status
Completed as part of coursework (team project)
