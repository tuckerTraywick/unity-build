#!/bin/sh
flags=" -std=gnu99 -Wall -Wextra -Wpedantic"
includes=" -Iinclude"
libraries=
defines=
valgrindFlags=" --leak-check=full --show-leak-kinds=all --track-origins=yes"
