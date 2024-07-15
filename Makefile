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
	@if [ -d $(TARGET_DIR) ]; then \
		echo "Gershwin Library already appears to be installed."; \
	else \
		echo "Creating directories and copying files to $(TARGET_DIR)..."; \
		mkdir -p $(TARGET_DIR); \
		$(FIND_DIRS) | xargs -I {} cp -R {} $(TARGET_DIR); \
		echo "Creating tarball..."; \
		ARCH=$(shell dpkg --print-architecture) && tar -czvf gershwin-library-$$ARCH.tar.gz /Library .; \
	fi

uninstall:
	@if [ -d $(TARGET_DIR) ]; then \
		echo "Removing $(TARGET_DIR)..."; \
		rm -rf $(TARGET_DIR); \
		echo "$(TARGET_DIR) removed successfully."; \
	else \
		echo "Gershwin Library does not appear to be installed."; \
	fi

clean:
	@ARCH=$(shell dpkg --print-architecture); \
	FILE=gershwin-library-$$ARCH.tar.gz; \
	if [ -f $$FILE ]; then \
		echo "Removing $$FILE..."; \
		rm -f $$FILE; \
		echo "$$FILE removed successfully."; \
	else \
		echo "Nothing to clean."; \
	fi