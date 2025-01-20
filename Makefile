.PHONY: test

test:
	@echo "Running tests..."
	@npx --yes bats --print-output-on-failure tests
