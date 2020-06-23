cmake_minimum_required(VERSION 3.10)
project(unit_test)
message("PROJECT_SOURCE_DIR" ${PROJECT_SOURCE_DIR})

enable_testing()
add_subdirectory(local_warehouse)
add_subdirectory(order)
