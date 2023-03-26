# sudoas

A wrapper for **doas** that allows you to use **sudo** arguments.

If an option is not supported by **doas**, it will be ignored.

## Install

Copy the `sudo.bash` file to `~/.local/bin/sudo` and make it executable.

> Be sure that the `doas` command is available in your `$PATH`.

## Usage

```bash
sudo [options] command
```

## Options

Here is a list of the supported options:

### -h, --help

Print a help message.

### -V, --version

Print the version number.

### -n, --non-interactive

Do not prompt for a password.

> This option is forwarded to **doas** as `-n`

### -u, --user

Specify the user to run the command as.

> This option is forwarded to **doas** as `-u`

### -s, --shell

Specify the shell to use.

> This option is forwarded to **doas** as `-s`
