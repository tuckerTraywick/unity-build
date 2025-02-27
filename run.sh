#/bin/sh
$valgrindFlags="--leak-check=full --show-leak-kinds=all --track-origins=yes"

./build.sh $@

test=false
valgrind=false
while getopts "tv" option; do
	case $option in
		t)
		test=true
		;;
		v)
		valgrind=true
		;;
	esac
done

if $test; then
	echo
	echo "---- TESTING ----"
	if $valgrind; then
		valgrind $valgrindFlags binary/test
	else
		./binary/test
	fi
fi

if [ -f binary/run ]; then
	echo
	echo "---- RUNNING ----"
	if $valgrind; then
		valgrind $valgrindFlags binary/run
	else
		./binary/run
	fi
fi
