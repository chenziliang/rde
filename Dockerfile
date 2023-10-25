<<<<<<< HEAD
FROM ubuntu:22.04
=======
FROM ubuntu:21.10
>>>>>>> 05bb903 (clang-format)

RUN yes | unminimize

# ARG for quick switch to a given ubuntu mirror
ARG apt_archive="http://archive.ubuntu.com"
RUN sed -i "s|http://archive.ubuntu.com|$apt_archive|g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive LLVM_VERSION=15 GCC_VERSION=12 GO_VERSION=1.18

RUN apt-get update \
    && apt-get install \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        curl \
        dnsutils \
        gnupg \
        iputils-ping \
        lsb-release \
        wget \
        --yes --no-install-recommends --verbose-versions \
    && export LLVM_PUBKEY_HASH="bda960a8da687a275a2078d43c111d66b1c6a893a3275271beedf266c1ff4a0cdecb429c7a5cccf9f486ea7aa43fd27f" \
    && wget -nv -O /tmp/llvm-snapshot.gpg.key https://apt.llvm.org/llvm-snapshot.gpg.key \
    && echo "${LLVM_PUBKEY_HASH} /tmp/llvm-snapshot.gpg.key" | sha384sum -c \
    && apt-key add /tmp/llvm-snapshot.gpg.key \
    && export CODENAME="$(lsb_release --codename --short | tr 'A-Z' 'a-z')" \
    && echo "deb https://apt.llvm.org/${CODENAME}/ llvm-toolchain-${CODENAME}-${LLVM_VERSION} main" >> \
        /etc/apt/sources.list \
    && apt-get clean

RUN apt-get update \
    && apt-get install \
        apt-file \
        bash \
        bat \
        curl \
        expect \
        git \
        gperf \
        iproute2 \
        inetutils-ping \
        jq \
        less \
        moreutils \
        nasm \
        ninja-build \
        openjdk-11-jdk \
        pigz \
        psmisc \
        ripgrep \
        rename \
        silversearcher-ag \
        software-properties-common \
        ssh \
        strace \
        sudo \
        telnet \
        tmux \
        tree \
        vim \
        yasm \
        zsh \
        --yes --no-install-recommends \
    && apt-get clean

RUN apt-get update \
    && apt-get install \
        bsdmainutils \
        build-essential \
        ccache \
        cmake \
        fakeroot \
        g++ \
        gcc \
        gdb \
        g++-${GCC_VERSION} \
        gcc-${GCC_VERSION} \
        golang-${GO_VERSION} \
        make \
        ninja-build \
        perl \
        pkg-config \
        python3 \
        python3-lxml \
        python3-requests \
        python3-termcolor \
        python3-lldb-${LLVM_VERSION} \
        # libclang-rt-${LLVM_VERSION}-dev \
        lld-${LLVM_VERSION} \
        lldb-${LLVM_VERSION} \
        llvm-${LLVM_VERSION} \
        llvm-${LLVM_VERSION}-dev \
        libclang-${LLVM_VERSION}-dev \
        clang-${LLVM_VERSION} \
        clang-tidy-${LLVM_VERSION} \
        clang-format-${LLVM_VERSION} \
        tzdata \
        --yes --no-install-recommends \
    && apt-get clean

# install libc++
RUN apt-get update \
    && apt-get install \
        libc++abi-13-dev \
        libc++-13-dev \
        --yes --no-install-recommends

RUN apt-get update \
    && apt-get install \
        apt-file \
        bash \
        bat \
        curl \
        git \
        iproute2 \
        inetutils-ping \
        less \
        jq \
        openjdk-11-jdk \
        psmisc \
        ripgrep \
        silversearcher-ag \
        ssh \
        strace \
        sudo \
        telnet \
        tmux \
        tree \
        vim \
        zsh \
        --yes --no-install-recommends
>>>>>>> 05bb903 (clang-format)

RUN apt-get update \
    && apt-get install \
        software-properties-common \
        man \
        manpages \
        manpages-dev \
        manpages-posix-dev \
        --yes --no-install-recommends \
    && apt-get clean

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get clean

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV SHELL /usr/bin/zsh

# Fix - No module named 'lldb.embedded_interpreter'
RUN ln -s /usr/lib/llvm-${LLVM_VERSION}/lib/python3.10/dist-packages/lldb/* /usr/lib/python3/dist-packages/lldb/

# This symlink required by gcc to find lld compiler
RUN ln -s /usr/bin/lld-${LLVM_VERSION} /usr/bin/ld.lld
# for external_symbolizer_path
RUN ln -s /usr/bin/llvm-symbolizer-${LLVM_VERSION} /usr/bin/llvm-symbolizer
# FIXME: workaround for "The imported target "merge-fdata" references the file" error
# https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/992e52c0b156a5ba9c6a8a54f8c4857ddd3d371d
RUN sed -i '/_IMPORT_CHECK_FILES_FOR_\(mlir-\|llvm-bolt\|merge-fdata\|MLIR\)/ {s|^|#|}' /usr/lib/llvm-${LLVM_VERSION}/lib/cmake/llvm/LLVMExports-*.cmake


# rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN curl https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > /usr/local/bin/aws_zsh_completer.sh && chmod +x /usr/local/bin/aws_zsh_completer.sh

# CPP advanced grep tool
RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/calltree.pl > /usr/local/bin/calltree && chmod +x /usr/local/bin/calltree
RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/cpptree.pl > /usr/local/bin/cpptree && chmod +x /usr/local/bin/cpptree
RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/deptree.pl > /usr/local/bin/deptree && chmod +x /usr/local/bin/deptree

# JAVA advanced grep tool
RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/java_calltree.pl > /usr/local/bin/java_calltree && chmod +x /usr/local/bin/java_calltree
RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/javatree.pl > /usr/local/bin/javatree && chmod +x /usr/local/bin/javatree

RUN curl https://raw.githubusercontent.com/satanson/cpp_etudes/master/csvtable.pl > /usr/local/bin/csvtable && chmod +x /usr/local/bin/csvtable


CMD ["/bin/zsh"]
