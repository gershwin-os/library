# Makefile

# Root check
ifeq ($(shell id -u), 0)
else
$(error This Makefile must be run as root or with sudo)
endif

# Define the target installation directory
TARGET_DIR := /Library

# Define the command to find directories and format them
FIND_DIRS := find . -mindepth 1 -maxdepth 1 -type d \( ! -name '.*' \) -exec printf "%s\n" {} + | awk '{ print ($$0 ~ / / ? "\"" $$0 "\"" : $$0) }'


install:
	@echo "Creating directories and copying files to $(TARGET_DIR)..."
	@mkdir -p $(TARGET_DIR)
	@$(FIND_DIRS) | xargs -I {} cp -R {} $(TARGET_DIR)

uninstall:
	@if [ -d $(TARGET_DIR) ]; then \
		echo "Removing $(TARGET_DIR)..."; \
		rm -rf $(TARGET_DIR); \
		echo "$(TARGET_DIR) removed successfully."; \
	else \
		echo "$(TARGET_DIR) does not exist."; \
	fi