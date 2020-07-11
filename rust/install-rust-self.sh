#!/usr/bin/env bash
set -eux

# curl https://sh.rustup.rs -sSf | sh

if [[ "$OSTYPE" == "msys" ]]; then
    CARGO_CONFIG_PATH="$USERPROFILE/.cargo"
else
    CARGO_CONFIG_PATH="${HOME}/.cargo"
fi

mkdir -p "${CARGO_CONFIG_PATH}"
cat <<EOF > "${CARGO_CONFIG_PATH}/config"
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'tuna'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
EOF

# 特殊指定版本
NEEDED_RUST_VERSION=nightly-2020-07-01
rustup toolchain install "${NEEDED_RUST_VERSION}"
rustup component add rls --toolchain "${NEEDED_RUST_VERSION}"
rustup component add clippy --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-analysis --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-src --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_VERSION}"

# 最新的健康nightly版本
echo
HEALTHY_NIGHTLY_VERSION=nightly-2020-07-11
rustup toolchain install "${HEALTHY_NIGHTLY_VERSION}"
rustup default "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rls
rustup component add clippy
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustc --print sysroot
rustup toolchain list