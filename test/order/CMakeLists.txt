cmake_minimum_required(VERSION 3.10)
project(test_order VERSION 1.0.0 LANGUAGES CXX)

set(MODULE_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
set(REPO_ROOT "${MODULE_ROOT}")
set(GOOGLETEST_ROOT ${REPO_ROOT}/external/googletest/googletest CACHE STRING "Google Test source root")
#include(${REPO_ROOT}/cmake/GTest.cmake)
#build_gtest()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
set(CMAKE_INSTALL_PREFIX ${REPO_ROOT}/ CACHE PATH "repo root" FORCE)
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
message("CMAKE_INSTALL_PREFIX: " ${CMAKE_INSTALL_PREFIX})
# Create the executable
add_executable(
    ${PROJECT_NAME}
    ${MODULE_ROOT}/src/local_warehouse.cpp
    ${MODULE_ROOT}/src/order.cpp
    test_order.cpp
    )

# find_package(Utility REQUIRED)
# find_package(LinuxAdaptor REQUIRED)

# target_link_libraries(test_order
#     PRIVATE Utility LinuxAdaptor
# )

target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${MODULE_ROOT}/include/
        ${GOOGLETEST_ROOT}
        ${GOOGLETEST_ROOT}/include
)

install (TARGETS ${PROJECT_NAME} DESTINATION ut)

include(${REPO_ROOT}/cmake/UnitTest.cmake)
set(COVERAGE_SOURCE_DIR "${MODULE_ROOT}/src/")
add_unit_test(${PROJECT_NAME})
