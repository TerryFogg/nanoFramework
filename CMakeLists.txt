#
# Copyright (c) .NET Foundation and Contributors
# See LICENSE file in the project root for full license information.
#
cmake_minimum_required(VERSION 3.30)

find_program(CCACHE_PROGRAM ccache)

if(CCACHE_PROGRAM)
  message(STATUS "Using ccache: ${CCACHE_PROGRAM}")
  set(CMAKE_C_COMPILER_LAUNCHER   ${CCACHE_PROGRAM})
  set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
endif()

include(CMakeToolsHelpers OPTIONAL)
include(ExternalProject)
set(CMAKE_BUILD_TYPE "Debug")

if(NOT BUILD_VERSION)
    set(BUILD_VERSION 0.0.0.0)
endif()

include(CMakeToolsHelpers OPTIONAL)
include(ExternalProject)

    add_subdirectory(MyTargets/ThreadX/CMake)
    return()

if (BUILD_VERBOSE)
    set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "ON" FORCE) # debug helper
endif()

# the following prevents launchin a build in the source tree
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)


string(TIMESTAMP BUILD_TIMESTAMP UTC)

if(NOT BUILD_VERSION)
    set(BUILD_VERSION 0.0.0.0)
endif()
project(nanoFramework VERSION ${BUILD_VERSION} LANGUAGES C CXX ASM)
