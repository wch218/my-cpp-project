# Dockerfile - Ubuntu-based C/C++ development image with vcpkg
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ARG USER=dev
ARG UID=1000
ARG GID=1000
ARG VCPKG_ROOT=/home/dev/vcpkg

RUN apt update && apt upgrade -y \
  && apt install -y --no-install-recommends \
    build-essential git curl wget ca-certificates pkg-config cmake ninja-build \
    gdb valgrind clang clang-tidy clang-format lldb autoconf automake libtool \
    make ccache cppcheck strace ltrace python3-pip unzip zip sudo git-lfs libssl-dev libpq-dev libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*

# add non-root user
RUN groupadd -g ${GID} ${USER} || true \
  && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USER} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
WORKDIR /work

# install conan for the non-root user
RUN python3 -m pip install --user conan \
  && echo 'export PATH=$HOME/.local/bin:$PATH' >> /home/${USER}/.profile

# bootstrap vcpkg for convenience
RUN git clone --depth=1 https://github.com/microsoft/vcpkg.git ${VCPKG_ROOT} \
  && ${VCPKG_ROOT}/bootstrap-vcpkg.sh || true

# set PATH for interactive shells
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> /home/${USER}/.profile

# default entry
ENTRYPOINT ["/bin/bash"]
