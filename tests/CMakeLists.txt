cmake_minimum_required(VERSION 3.16)

include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/heads/main.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(unit_tests test_sum.cpp)

target_link_libraries(unit_tests PRIVATE myproject_lib GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(unit_tests)
