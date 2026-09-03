# Dockerfile - Ubuntu-based C/C++ development image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ARG USER=dev
ARG UID=1000
ARG GID=1000

RUN apt update && apt upgrade -y \
  && apt install -y --no-install-recommends \
    build-essential git curl wget ca-certificates pkg-config cmake ninja-build \
    gdb valgrind clang clang-tidy clang-format lldb autoconf automake libtool \
    make ccache cppcheck strace ltrace python3-pip unzip zip sudo \
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

# default entry
ENTRYPOINT ["/bin/bash"]
