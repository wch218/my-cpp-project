#!/bin/bash
set -euo pipefail

# Enhanced Ubuntu C/C++ dev environment setup (GCC-first)
# Usage: chmod +x setup.sh && ./setup.sh
# Optional environment variables:
#  INSTALL_VCPKG=1      - bootstrap vcpkg into $HOME/vcpkg
#  INSTALL_SYS_PKGS=1   - install extra system libraries (libssl-dev, libpq-dev, libcurl4-openssl-dev, protobuf)
#  VCPKG_ROOT           - custom vcpkg path (default: $HOME/vcpkg)

INSTALL_VCPKG=${INSTALL_VCPKG:-1}
INSTALL_SYS_PKGS=${INSTALL_SYS_PKGS:-1}
VCPKG_ROOT=${VCPKG_ROOT:-$HOME/vcpkg}

sudo apt update
sudo apt upgrade -y

# Basic build & dev tools (GCC-focused)
sudo apt install -y build-essential git curl wget ca-certificates pkg-config \
  cmake ninja-build gdb valgrind autoconf automake libtool make ccache cppcheck strace ltrace python3-pip git-lfs

# Optional helpful tools
sudo apt install -y unzip zip

# Optional system libraries commonly used by C/C++ projects
if [ "${INSTALL_SYS_PKGS}" = "1" ]; then
  sudo apt install -y libssl-dev libpq-dev libboost-all-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev
fi

# Install Conan (C/C++ package manager) for dependency management
python3 -m pip install --user conan
export PATH="$HOME/.local/bin:$PATH"

# Configure ccache for faster rebuilds (for bash shells)
# Add variables only if not present
grep -qxF 'export CC="gcc"' ~/.profile || echo 'export CC="gcc"' >> ~/.profile
grep -qxF 'export CXX="g++"' ~/.profile || echo 'export CXX="g++"' >> ~/.profile
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.profile || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile

# Bootstrap vcpkg (optional)
if [ "${INSTALL_VCPKG}" = "1" ]; then
  if [ ! -d "${VCPKG_ROOT}" ]; then
    echo "Bootstrapping vcpkg into ${VCPKG_ROOT}"
    git clone https://github.com/microsoft/vcpkg.git "${VCPKG_ROOT}"
    "${VCPKG_ROOT}/bootstrap-vcpkg.sh" || true
  else
    echo "vcpkg already exists at ${VCPKG_ROOT}, skipping clone"
  fi
  echo "To use vcpkg in CMake add: -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
fi

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

# Provide small usage hint
cat <<'EOF'
Setup complete.
- Restart your shell or run: source ~/.profile
- Examples:
    mkdir -p build && cd build
    cmake -S .. -B . -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
    cmake --build . -j$(nproc)
    ctest --output-on-failure
- If you use vcpkg: add -DCMAKE_TOOLCHAIN_FILE=$HOME/vcpkg/scripts/buildsystems/vcpkg.cmake to your cmake command
EOF
