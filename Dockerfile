FROM ubuntu:20.04

RUN yes | unminimize

ENV DEBIAN_FRONTEND=noninteractive LLVM_VERSION=13

# RUN sed -i 's|http://archive|http://ru.archive|g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install ca-certificates lsb-release wget gnupg apt-transport-https \
        --yes --no-install-recommends --verbose-versions \
    && export LLVM_PUBKEY_HASH="bda960a8da687a275a2078d43c111d66b1c6a893a3275271beedf266c1ff4a0cdecb429c7a5cccf9f486ea7aa43fd27f" \
    && wget -nv -O /tmp/llvm-snapshot.gpg.key https://apt.llvm.org/llvm-snapshot.gpg.key \
    && echo "${LLVM_PUBKEY_HASH} /tmp/llvm-snapshot.gpg.key" | sha384sum -c \
    && apt-key add /tmp/llvm-snapshot.gpg.key \
    && export CODENAME="$(lsb_release --codename --short | tr 'A-Z' 'a-z')" \
    && echo "deb [trusted=yes] http://apt.llvm.org/${CODENAME}/ llvm-toolchain-${CODENAME}-${LLVM_VERSION} main" >> \
        /etc/apt/sources.list

RUN apt-get update \
    && apt-get install \
        ccache \
        cmake \
        curl \
        expect \
        g++ \
        gcc \
        gdb \
        make \
        ninja-build \
        perl \
        pkg-config \
        python3 \
        python3-lxml \
        python3-requests \
        python3-termcolor \
        tzdata \
        llvm-${LLVM_VERSION} \
        clang-${LLVM_VERSION} \
        clang-format-${LLVM_VERSION} \
        clang-tidy-${LLVM_VERSION} \
        lld-${LLVM_VERSION} \
        lldb-${LLVM_VERSION} \
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

RUN apt-get update \
    && apt-get install \
        software-properties-common \
        man \
        manpages \
        manpages-dev \
        manpages-posix-dev \
        --yes --no-install-recommends

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

RUN apt-get update \
    && apt-get install \
    apt-utils \
    --yes --no-install-recommends

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV SHELL /usr/bin/zsh

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
