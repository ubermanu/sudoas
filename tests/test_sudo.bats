#!/usr/bin/env bats

@test "prints help" {
  run ./sudo.bash
  [ "$status" -eq 0 ]
  [ $(echo "$output" | grep -c "THIS IS A COMPATIBILITY SCRIPT FOR DOAS") -gt 0 ]
}

@test "basic usage" {
  run expect <<-EOF
  set timeout 1
  spawn ./sudo.bash echo "hello"
  expect "password:"
  expect eof
EOF

  [ "$status" -eq 0 ]
  [ $(echo "$output" | grep -c "password:") -gt 0 ]
}

@test "ignore the prompt option" {
  run expect <<-EOF
  set timeout 1
  spawn ./sudo.bash --prompt="Password:" echo "hello"
  expect "password:"
  expect eof
EOF

  [ "$status" -eq 0 ]
  [ $(echo "$output" | grep -c "password:") -gt 0 ]
}
