#/bin/sh
flags="-O -g3 -std=gnu99 -Wall -Wextra -Wpedantic"
includes="-Iinclude"
libraries=
sourceCommand="gcc $flags $includes build/source.c -c -o build/source.o $libraries"
testCommand="gcc $flags $includes build/source.o build/test.c -o binary/test $libraries"

createUnit() {
	for file in $(find $1 -type f ! -name "main.c")
	do
		echo "#include \"../$file\""
	done
}

test=false
while getopts "t" option; do
	if [ $option == "t" ]; then
		test=true
	fi
done

clear
echo "---- BUILDING ----"
# Cleanup.
mkdir -p build binary
rm -rf build/* binary/*

# Create the source compilation unit and executable.
createUnit source > build/source.c
echo $sourceCommand
eval $sourceCommand
if [ -f source/main.c ]; then
	gcc $flags $includes $libraries build/source.o source/main.c -o binary/run
fi

# Create the test compilation unit and executable.
if $test; then
	createUnit tests > build/test.c
	echo
	echo $testCommand
	eval $testCommand
fi
