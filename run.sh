#/bin/sh
./build.sh $1

if [ $1 ]; then
	echo
	echo "---- TESTING ----"
	./binary/test
fi

if [ -f binary/run ]; then
	echo
	echo "---- RUNNING ----"
	./binary/run
fi
