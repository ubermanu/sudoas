SHELL := /bin/bash
INSTALL_DIR := ~/.local/bin

.PHONY: test

test:
	@echo "Running tests..."
	@./tests/test_sudo.bats

install:
	@echo "Installing sudo..."
	install -Dm755 sudo.bash $(INSTALL_DIR)/sudo

uninstall:
	@echo "Uninstalling sudo..."
	rm $(INSTALL_DIR)/sudo
