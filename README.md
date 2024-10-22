<div align="center">

# asdf-germanium [![Build](https://github.com/saul-salazar-dotcom/asdf-germanium/actions/workflows/build.yml/badge.svg)](https://github.com/saul-salazar-dotcom/asdf-germanium/actions/workflows/build.yml) [![Lint](https://github.com/saul-salazar-dotcom/asdf-germanium/actions/workflows/lint.yml/badge.svg)](https://github.com/saul-salazar-dotcom/asdf-germanium/actions/workflows/lint.yml)

[germanium](https://github.com/siddhantac/germanium) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-germanium](#asdf-germanium--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `unzip`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add germanium
# or
asdf plugin add germanium https://github.com/saul-salazar-dotcom/asdf-germanium.git
```

germanium:

```shell
# Show all installable versions
asdf list-all germanium

# Install specific version
asdf install germanium latest

# Set a version globally (on your ~/.tool-versions file)
asdf global germanium latest

# Now germanium commands are available
germanium
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/saul-salazar-dotcom/asdf-germanium/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Zeno Jiricek](https://github.com/airtonix/)
