INSTALL_DIR=/usr/local/bin
CONFIG_DIR=/etc/hrzn

# Colors for better readability
GREEN=\033[0;32m
RED=\033[0;31m
YELLOW=\033[0;33m
NC=\033[0m

.PHONY: install uninstall

install: hrzn config scripts
	@printf "$(GREEN)hrzn installed successfully!$(NC)\n"
	@printf "$(YELLOW)You can now use hrzn by running: $(INSTALL_DIR)/$(TOOL_NAME)$(NC)\n"
	@printf "$(YELLOW)Configuration files are located at: $(CONFIG_DIR)$(NC)\n"

uninstall:
	rm -f $(INSTALL_DIR)/hrzn
	rm -r $(INSTALL_DIR)/lib/hrzn/
	rm -f $(CONFIG_DIR)/config

hrzn:
	VERSION="0.4"
	@printf "$(YELLOW) Installing hrzn...$(NC)\n"
	cat hrzn.sh > $(INSTALL_DIR)/hrzn
	chmod +x $(INSTALL_DIR)/hrzn

lib=lib/*.sh
scripts:
	mkdir -p $(INSTALL_DIR)/lib/hrzn/
	cp $(lib) $(INSTALL_DIR)/lib/hrzn/


config:
	echo external_storage="/external_storage/xchange_horizon/" > $(CONFIG_DIR)/config
	chmod 644 $(CONFIG_DIR)/config
