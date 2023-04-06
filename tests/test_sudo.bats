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
