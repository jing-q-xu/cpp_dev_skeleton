cmake_minimum_required(VERSION 3.10)
project(surgerii)

option(BUILD_UT "build for ut" OFF)
option(BUILD_APP "build all application" OFF)

#if(BUILD_UT)
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
#    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
#endif(BUILD_UT)

# if(BUILD_LIB)
#     include(CMakeLists_lib.txt)
# endif()

if(BUILD_UT)
    enable_testing()
    add_subdirectory(test)
else()
    # if(BUILD_APP)
    #     include(CMakeLists_app.txt)
    # endif(BUILD_APP)
endif(BUILD_UT)
