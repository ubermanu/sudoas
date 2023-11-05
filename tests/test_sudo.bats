#!/usr/bin/env bats

# Force the script to use the test environment (print the args)
export TEST=1

@test "prints help" {
  run ./sudo.bash
  [ "$status" -eq 0 ]
  [ $(echo "$output" | grep -c "THIS IS A COMPATIBILITY SCRIPT FOR DOAS") -gt 0 ]
}

@test "basic usage" {
  run ./sudo.bash echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "echo hello" ]
}

@test "ignore the prompt option" {
  run ./sudo.bash --prompt="Password:" echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "echo hello" ]
}

@test "map the supported options" {
  run ./sudo.bash --non-interactive --user=root --shell=/bin/zsh echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "-n -u root -s /bin/zsh echo hello" ]
}

@test "map the supported options (alternate syntax)" {
  run ./sudo.bash -n --user root -s /bin/zsh echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "-n -u root -s /bin/zsh echo hello" ]
}

@test "allow args to be piped if the command allows it" {
  run ./sudo.bash pacman -Rns -
  [ "$status" -eq 0 ]
  [ "$output" = "pacman -Rns -" ]
}

@test "preserve args after the command" {
  run ./sudo.bash command -p --preserve-env --some-arg
  [ "$status" -eq 0 ]
  [ "$output" = "command -p --preserve-env --some-arg" ]
}

@test "ignore unsupported sudo options (handled in script)" {
  run ./sudo.bash --preserve-env --command="echo hello" echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "echo hello" ]
}

@test "ignore unknown sudo options" {
  run ./sudo.bash --unknown-option echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "echo hello" ]
}

@test "move environment variables before the command" {
  run ./sudo.bash TERMINFO=/usr/lib/kitty/terminfo echo hello
  [ "$status" -eq 0 ]
  [ "$output" = "echo hello" ]
}
