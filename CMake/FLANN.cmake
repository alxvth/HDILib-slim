include(ExternalProject)
include(${CMAKE_SOURCE_DIR}/CMake/Incredibuild.cmake)

SET(HDI_FLANN_USED "Local" CACHE STRING "FLANN Used") 
SET_PROPERTY(CACHE HDI_FLANN_USED PROPERTY STRINGS "Local" "Build" ) # this can be extended for Conan and OS specific package managers

#OPTION LOCAL
if(HDI_FLANN_USED STREQUAL "Local")
if (CMAKE_GENERATOR STREQUAL Xcode)
    find_program(BREW NAMES brew)
    if("${BREW}" STRGREATER "")
        message(STATUS "Running on macOS Darwin using ${BREW}")
        execute_process(COMMAND ${BREW} --prefix flann OUTPUT_VARIABLE BREW_FLANN_PREFIX OUTPUT_STRIP_TRAILING_WHITESPACE)
    endif("${BREW}" STRGREATER "")
    
    #finding flann
    if(EXISTS ${BREW_FLANN_PREFIX})
        message(STATUS "Flann found from brew at ${BREW_FLANN_PREFIX}.")
		include_directories(${HDI_FLANN_INCLUDE_DIR})
    else()
        # there should probably be an alternative in here for setting the flann path
        message(WARNING "Flann not found.")
    endif(EXISTS ${BREW_FLANN_PREFIX})
#Win/Linux
else(CMAKE_GENERATOR STREQUAL Xcode)
	include_directories($ENV{FLANN_DIR}/include)
	 message(STATUS "Local Flann Include Dir:  $ENV{FLANN_DIR}/include")
endif(CMAKE_GENERATOR STREQUAL Xcode)
endif(HDI_FLANN_USED STREQUAL "Local")

# OPTION BUILD
if(HDI_FLANN_USED STREQUAL "Build")
if (MSVC)
set(FLANN_LIB_SRC ${CMAKE_CURRENT_BINARY_DIR}/flann/src/flann-build/lib/$<CONFIG>/flann_s.lib)
set(FLANN_LIB_TARGET ${EXECUTABLE_OUTPUT_PATH}/$<CONFIG>/flann_s.lib)

SET_INCREDIBUILD_COMMAND(Flann)
ExternalProject_Add(flann
	GIT_REPOSITORY https://github.com/mariusmuja/flann
	GIT_TAG 1.8.5
    GIT_SHALLOW ON
	PREFIX flann
	CMAKE_ARGS -DPYTHON_EXECUTABLE=NOT_FOUND -DBUILD_SHARED_LIBS=OFF -DHDF5_DIR=HDF5-NOT-FOUND -DBUILD_PYTHON_BINDINGS=OFF -DBUILD_MATLAB_BINDINGS=OFF -DBUILD_CUDA_LIB=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_DOC=OFF -DUSE_MPI=OFF -dBUILD_C_BINDINGS=OFF -DHDF5_IS_PARALLEL=OFF
	INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLANN_LIB_SRC} ${FLANN_LIB_TARGET}
	BUILD_COMMAND ${INCREDIBUILD_COMMAND}
)
else(MSVC)
    message(STATUS "FLANN BUILD DIR=" ${CMAKE_CURRENT_BINARY_DIR}/flann/src/flann-build/lib/$<CONFIG>/)

    set(FLANN_LIB_SRC ${CMAKE_CURRENT_BINARY_DIR}/flann/src/flann-build/lib/$<CONFIG>/libflann_s.a)
    set(FLANN_LIB_TARGET ${EXECUTABLE_OUTPUT_PATH}/$<CONFIG>/libflann_s.a)

    ExternalProject_Add(flann
    GIT_REPOSITORY https://github.com/mariusmuja/flann
    GIT_TAG 1.8.4
    GIT_SHALLOW ON
    PREFIX flann
    CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER} -DPYTHON_EXECUTABLE=NOT_FOUND -DBUILD_SHARED_LIBS=ON -DHDF5_DIR=HDF5-NOT-FOUND -DBUILD_PYTHON_BINDINGS=OFF -DBUILD_MATLAB_BINDINGS=OFF -DBUILD_CUDA_LIB=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_DOC=OFF -DUSE_MPI=OFF -dBUILD_C_BINDINGS=ON -DHDF5_IS_PARALLEL=OFF
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLANN_LIB_SRC} ${FLANN_LIB_TARGET}
)
endif(MSVC)

ExternalProject_Get_Property(flann SOURCE_DIR)
set(HDI_FLANN_BUILD_INCLUDE_DIR  ${SOURCE_DIR}/src/cpp CACHE PATH "" FORCE)
include_directories(${HDI_FLANN_BUILD_INCLUDE_DIR})
message (STATUS "Build Flann Include Dir: ${HDI_FLANN_BUILD_INCLUDE_DIR}")
endif(HDI_FLANN_USED STREQUAL "Build")


