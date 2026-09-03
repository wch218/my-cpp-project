cmake_minimum_required(VERSION 3.16)
project(proto_example)

find_package(Protobuf REQUIRED)

protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/echo.proto)
add_executable(proto_example main.cpp ${PROTO_SRCS} ${PROTO_HDRS})

target_include_directories(proto_example PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(proto_example PRIVATE protobuf::libprotobuf)
