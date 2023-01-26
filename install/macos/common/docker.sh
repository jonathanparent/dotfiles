#!/usr/bin/env bash

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -Eeuox pipefail
fi

function get_cpu_arch() {
    local cpu
    cpu=$(uname -m)
    echo -n "${cpu}"
}

function install_lima() {
    brew install lima
}

function install_docker_cli() {
    local docker_cli_version="20.10.10"

    local tmp_dir
    tmp_dir="$(mktemp -d /tmp/docker-cli-XXXXXXXXXX)"
    trap 'rm -rf "${tmp_dir}"' EXIT INT TERM HUP

    local cpu
    cpu=$(get_cpu_arch)
    if [[ "${cpu}" == "arm64" ]]; then
        cpu="aarch64"
    fi

    local download_url="https://download.docker.com/mac/static/stable/${cpu}/docker-${docker_cli_version}.tgz"
    local tgz_file="${tmp_dir%/}/docker.tgz"
    curl -fSL "${download_url}" -o "${tgz_file}"

    tar -zxvf "${tgz_file}" --strip-components 1 -C "${tmp_dir}"

    local tgz_bin_path="${tmp_dir%/}/docker"
    local home_bin_dir="${HOME%/}/.local/bin"
    local home_bin_path="${home_bin_dir%/}/docker"

    mkdir -p "${home_bin_dir}"
    mv -v "${tgz_bin_path}" "${home_bin_path}"
}

function install_docker_compose() {
    local tmp_dir
    tmp_dir="$(mktemp -d /tmp/docker-compose-XXXXXXXXXX)"

    local cpu
    cpu=$(get_cpu_arch)
    if [[ "${cpu}" == "arm64" ]]; then
        cpu="aarch64"
    fi

    local download_url="https://github.com/docker/compose/releases/latest/download/docker-compose-darwin-${cpu}"
    local exec_file="${tmp_dir%/}/docker-compose"
    curl -fSL "${download_url}" -o "${exec_file}"

    local home_bin_file="${HOME%/}/.local/bin/docker-compose"
    mv -v "${exec_file}" "${home_bin_file}"
    chmod +x "${home_bin_file}"
}

function main() {
    install_lima
    install_docker_cli
    install_docker_compose
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
