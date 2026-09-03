# Simple library used by the executable and tests

add_library(myproject_lib lib.cpp)
target_include_directories(myproject_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE myproject_lib)
