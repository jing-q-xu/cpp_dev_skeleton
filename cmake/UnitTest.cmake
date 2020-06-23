enable_testing()
include(GoogleTest)

macro(package_add_test_with_libraries TESTNAME FILES LIBRARIES TEST_WORKING_DIRECTORY)
    add_executable(${TESTNAME} ${FILES})
    target_link_libraries(${TESTNAME} gtest gmock gtest_main ${LIBRARIES})
    gtest_discover_tests(${TESTNAME}
        WORKING_DIRECTORY ${TEST_WORKING_DIRECTORY}
    )
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)
endmacro()

macro(package_add_test TESTNAME)
    # create an exectuable in which the tests will be stored
    add_executable(${TESTNAME} ${ARGN})
    # link the Google test infrastructure, mocking library, and a default main fuction to
    # the test executable.  Remove g_test_main if writing your own main function.
    target_link_libraries(${TESTNAME} gtest gmock gtest_main)
    # gtest_discover_tests replaces gtest_add_tests,
    # see https://cmake.org/cmake/help/v3.10/module/GoogleTest.html for more options to pass to it
    gtest_discover_tests(${TESTNAME}
        # set a working directory so your project root so that you can find test data via paths relative to the project root
        WORKING_DIRECTORY ${PROJECT_DIR}
        PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_DIR}"
    )
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)
endmacro()

macro(add_unit_test TESTNAME)
    # set(CMAKE_MODULE_PATH "${REPO_ROOT}/buildut")
    # message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
    # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
    # set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(${TESTNAME} PRIVATE gcov)
        target_compile_options(${TESTNAME} PUBLIC $<$<CXX_COMPILER_ID:GNU>:--coverage>)
    endif ()

    target_link_libraries(${TESTNAME} PRIVATE gtest gtest_main mockcpp pthread)
    gtest_discover_tests(${TESTNAME}
        # set a working directory so your project root so that you can find test data via paths relative to the project root
        # EXTRA_ARGS "--gtest_output=xml:testresults.xml"
        # WORKING_DIRECTORY ${REPO_ROOT}/bd
        # PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${REPO_ROOT}/bd"
    )
    set_target_properties(${TESTNAME} PROPERTIES FOLDER tests)

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        if((PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME) OR ENABLE_COVRAGE)
            include(${REPO_ROOT}/cmake/CodeCoverage.cmake)
            #SETUP_TARGET_FOR_COVERAGE_GCOVR_XML(
            SETUP_TARGET_FOR_COVERAGE_LCOV(
                NAME "${TESTNAME}"
                EXECUTABLE ctest
            )
        endif()
    endif ()
    
endmacro()
