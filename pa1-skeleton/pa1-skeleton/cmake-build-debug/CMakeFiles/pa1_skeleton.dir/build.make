# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2017.3\bin\cmake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2017.3\bin\cmake\bin\cmake.exe" -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/pa1_skeleton.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/pa1_skeleton.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/pa1_skeleton.dir/flags.make

CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj: CMakeFiles/pa1_skeleton.dir/flags.make
CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj: ../pa1-test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\pa1_skeleton.dir\pa1-test.c.obj   -c C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1-test.c

CMakeFiles/pa1_skeleton.dir/pa1-test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/pa1_skeleton.dir/pa1-test.c.i"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1-test.c > CMakeFiles\pa1_skeleton.dir\pa1-test.c.i

CMakeFiles/pa1_skeleton.dir/pa1-test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/pa1_skeleton.dir/pa1-test.c.s"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1-test.c -o CMakeFiles\pa1_skeleton.dir\pa1-test.c.s

CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.requires:

.PHONY : CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.requires

CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.provides: CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.requires
	$(MAKE) -f CMakeFiles\pa1_skeleton.dir\build.make CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.provides.build
.PHONY : CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.provides

CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.provides.build: CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj


CMakeFiles/pa1_skeleton.dir/pa1.c.obj: CMakeFiles/pa1_skeleton.dir/flags.make
CMakeFiles/pa1_skeleton.dir/pa1.c.obj: ../pa1.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/pa1_skeleton.dir/pa1.c.obj"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles\pa1_skeleton.dir\pa1.c.obj   -c C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1.c

CMakeFiles/pa1_skeleton.dir/pa1.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/pa1_skeleton.dir/pa1.c.i"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1.c > CMakeFiles\pa1_skeleton.dir\pa1.c.i

CMakeFiles/pa1_skeleton.dir/pa1.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/pa1_skeleton.dir/pa1.c.s"
	C:\PROGRA~2\Dev-Cpp\MinGW64\bin\gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\pa1.c -o CMakeFiles\pa1_skeleton.dir\pa1.c.s

CMakeFiles/pa1_skeleton.dir/pa1.c.obj.requires:

.PHONY : CMakeFiles/pa1_skeleton.dir/pa1.c.obj.requires

CMakeFiles/pa1_skeleton.dir/pa1.c.obj.provides: CMakeFiles/pa1_skeleton.dir/pa1.c.obj.requires
	$(MAKE) -f CMakeFiles\pa1_skeleton.dir\build.make CMakeFiles/pa1_skeleton.dir/pa1.c.obj.provides.build
.PHONY : CMakeFiles/pa1_skeleton.dir/pa1.c.obj.provides

CMakeFiles/pa1_skeleton.dir/pa1.c.obj.provides.build: CMakeFiles/pa1_skeleton.dir/pa1.c.obj


# Object files for target pa1_skeleton
pa1_skeleton_OBJECTS = \
"CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj" \
"CMakeFiles/pa1_skeleton.dir/pa1.c.obj"

# External object files for target pa1_skeleton
pa1_skeleton_EXTERNAL_OBJECTS =

pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj
pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/pa1.c.obj
pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/build.make
pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/linklibs.rsp
pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/objects1.rsp
pa1_skeleton.exe: CMakeFiles/pa1_skeleton.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable pa1_skeleton.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\pa1_skeleton.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/pa1_skeleton.dir/build: pa1_skeleton.exe

.PHONY : CMakeFiles/pa1_skeleton.dir/build

CMakeFiles/pa1_skeleton.dir/requires: CMakeFiles/pa1_skeleton.dir/pa1-test.c.obj.requires
CMakeFiles/pa1_skeleton.dir/requires: CMakeFiles/pa1_skeleton.dir/pa1.c.obj.requires

.PHONY : CMakeFiles/pa1_skeleton.dir/requires

CMakeFiles/pa1_skeleton.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\pa1_skeleton.dir\cmake_clean.cmake
.PHONY : CMakeFiles/pa1_skeleton.dir/clean

CMakeFiles/pa1_skeleton.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug C:\Users\user\Desktop\2018-1\architecture\assignment\pa1-skeleton\pa1-skeleton\cmake-build-debug\CMakeFiles\pa1_skeleton.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/pa1_skeleton.dir/depend

