#!/bin/sh
# Parse the flags.
test=false
valgrind=false
configuration=""
while getopts "tvb:" option; do
	case $option in
		t)
			test=true
			;;
		v)
			valgrind=true
			;;
		b)
			configuration=$OPTARG
			;;
	esac
done

# Configure the build.
if [ ! -f "configuration/$configuration.sh" -o ! "$configuration" ]; then
	echo "Build must have configuration."
	exit 1
fi
source "configuration/$configuration.sh"

# Generate the commands the script uses to compile and link the program and tests.
sourceCommand="$compiler $flags $defines $includes build/source.c -c -o build/source.o $libraries"
executableCommand="$compiler $flags $defines $includes build/source.o source/main.c -o binary/run $libraries"
testCommand="$compiler $flags $defines $includes build/source.o build/test.c -o binary/test $libraries"

# Echoes a single C file that includes every file in the first argument's directory except 'main.c'.
createUnit() {
	for file in $(find "$1" -type f ! -name "main.c")
	do
		echo "#include \"../$file\""
	done
}

# Cleanup.
echo "---- BUILDING ----"
mkdir -p build binary
rm -rf build/* binary/*

# Create the source compilation unit and executable.
createUnit source > build/source.c
echo $sourceCommand
eval $sourceCommand
if [ -f source/main.c ]; then
	eval $executableCommand
fi

# Create the test compilation unit and executable.
if "$test"; then
	createUnit tests > build/test.c
	echo
	echo $testCommand
	eval $testCommand
fi
