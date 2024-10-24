#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/matsuyoshi30/germanium"
TOOL_NAME="germanium"
TOOL_TEST="germanium --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if germanium is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"
	processor=$(get_machine_processor)
	os=$(get_machine_os)

	url="$GH_REPO/releases/download/${version}/${TOOL_NAME}_${version:1}_${os}_${processor}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename.tar.gz" -C - "$url.tar.gz" || curl "${curl_opts[@]}" -o "$filename.zip" -C - "$url.zip" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

get_machine_os() {
	case "${OSTYPE}" in
	darwin*) echo "darwin" ;;
	linux*) echo "linux" ;;
	*)
		# dump error to stderr
		echo "asdf-$TOOL_NAME: $OSTYPE is not supported" >&2
		exit 1
		;;
	esac
}

get_machine_processor() {
	KERNEL=$(uname -m)
	case "${KERNEL}" in
	x86_64*) echo 'x86_64' ;;
	i386*) echo 'i386' ;;
	arm64*) echo 'arm64' ;;
	*)
		# dump error to stderr
		echo "asdf-$TOOL_NAME: $KERNEL is not supported" >&2
		exit 1
		;;
	esac
}
