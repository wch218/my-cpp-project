# my-cpp-project

A minimal C/C++ starter project with CMake, GoogleTest, Docker, VS Code devcontainer and GitHub Actions CI.

## Quick start

Prerequisites: CMake >= 3.16, Ninja, a C/C++ compiler (GCC or Clang).

Clone:

  git clone https://github.com/wch218/my-cpp-project.git
  cd my-cpp-project

Build (out-of-source):

  mkdir -p build && cd build
  cmake -S .. -B . -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
  cmake --build . -j$(nproc)

Run executable:

  ./myapp

Run tests:

  ctest --test-dir . --output-on-failure

## Using vcpkg

If you use vcpkg, add the toolchain file when configuring CMake:

  cmake -S .. -B . -G Ninja -DCMAKE_TOOLCHAIN_FILE=$HOME/vcpkg/scripts/buildsystems/vcpkg.cmake

## Docker

Build the development image:

  docker build -t cpp-dev:latest .

Run an interactive shell with your project mounted:

  docker run --rm -it -v $(pwd):/work -w /work cpp-dev:latest /bin/bash

## VS Code devcontainer

Open this folder in VS Code and use Remote-Containers: "Open Folder in Container". The devcontainer is configured in `.devcontainer/devcontainer.json`.

## CI

A GitHub Actions workflow is included at `.github/workflows/ci.yml` which builds and runs tests on push/pull_request to `main` with both GCC and Clang.
