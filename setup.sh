#!/bin/bash
set -euo pipefail

# Ubuntu C/C++ dev environment setup
# Usage: chmod +x setup.sh && ./setup.sh

sudo apt update
sudo apt upgrade -y

# Basic build & dev tools
sudo apt install -y build-essential git curl wget ca-certificates pkg-config \
  cmake ninja-build gdb valgrind clang clang-tidy clang-format lldb \
  autoconf automake libtool make ccache cppcheck strace ltrace python3-pip

# Optional helpful tools
sudo apt install -y unzip zip

# Install Conan (C/C++ package manager) for dependency management
python3 -m pip install --user conan
# Add local pip bin to PATH for current session if needed
export PATH="$HOME/.local/bin:$PATH"

# Configure ccache for faster rebuilds (for bash shells)
echo 'export CC="ccache gcc"' >> ~/.profile
echo 'export CXX="ccache g++"' >> ~/.profile
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile

# (Optional) vcpkg bootstrap helper (commented out — uncomment if you want vcpkg)
# git clone https://github.com/microsoft/vcpkg.git $HOME/vcpkg
# $HOME/vcpkg/bootstrap-vcpkg.sh

# gtest system package build (optional helper)
if ! dpkg -s libgtest-dev >/dev/null 2>&1; then
  sudo apt install -y libgtest-dev || true
  if [ -d /usr/src/gtest ]; then
    pushd /usr/src/gtest >/dev/null
    sudo cmake . || true
    sudo make || true
    sudo cp *.a /usr/lib || true
    popd >/dev/null
  fi
fi

echo "Setup complete. Restart your shell or run: source ~/.profile"
echo "Usage examples:"
echo "  mkdir build && cd build"
echo "  cmake -S .. -B . -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo"
echo "  cmake --build . -j$(nproc)"
echo "  ctest --output-on-failure"
