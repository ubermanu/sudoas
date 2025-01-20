.PHONY: test

test:
	@echo "Running tests..."
	@bats --print-output-on-failure tests
