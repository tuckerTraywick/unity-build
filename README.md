# A simple single-unit build script for C projects
This repository is a skeleton for a small C project that includes 2 shell scripts for building and running code and unit tests. They both build the project by combining every C file into one and then compiling it as one translation unit.

## Project structure
Source files for your project should be put in the `source` directory, includes should be put in the `include` directory, and source files for unit tests should be put in the `tests` directory. All 3 directories can have arbitrary nesting; subdirectories don't affect the build process. `source` and `tests` should both have a .c file that defines a `main()` function.

## Usage
To configure the build, modify the variables at the top of `build.sh`. To build the project into an object file and an executable, call `build.sh`. Pass `-t` to also build the tests. To build and run the project, call `run.sh`. Pass `-t` to also run the tests and pass `-v` to run the build and test with valgrind.
