FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive LLVM_VERSION=12

RUN sed -i 's|http://archive|http://ru.archive|g' /etc/apt/sources.list

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
        bash \
        zsh \
        ccache \
        cmake \
        curl \
        expect \
        g++ \
        gcc \
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
        clang-tidy-${LLVM_VERSION} \
        lld-${LLVM_VERSION} \
        lldb-${LLVM_VERSION} \
        --yes --no-install-recommends

RUN apt-get update \
    && apt-get install \
        vim \
        tmux \
        --yes --no-install-recommends

# rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN curl https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > /usr/local/bin/aws_zsh_completer.sh && chmod +x /usr/local/bin/aws_zsh_completer.sh

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

CMD ["/bin/zsh"]
