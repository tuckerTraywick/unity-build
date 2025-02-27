#!/bin/sh
# Build the code.
source ./build.sh $@

# Run the tests.
if "$test"; then
	echo
	echo "---- TESTING ----"
	if "$valgrind"; then
		valgrind $valgrindFlags binary/test
	else
		./binary/test
	fi
fi

# Run the build.
if [ -f binary/run ]; then
	echo
	echo "---- RUNNING ----"
	if "$valgrind"; then
		valgrind $valgrindFlags binary/run
	else
		./binary/run
	fi
fi
