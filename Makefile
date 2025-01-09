RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
RESET = \033[0m

# Do everything.
all: init xcode brew bundle defaults azcompletion duti zed_settings copy_configs zprofile sshkeygen folderaction manual_configs
	@echo "${GREEN}macOS setup is complete.${RESET}"

# Set initial preference.
init:
	@echo "${BLUE}Checking macOS version...${RESET}"
	@os_version=$$(sw_vers -productVersion); \
	major_version=$$(echo $$os_version | cut -d '.' -f 1); \
	minor_version=$$(echo $$os_version | cut -d '.' -f 2); \
	if [ "$$major_version" -gt 15 ] || { [ "$$major_version" -eq 15 ] && [ "$$minor_version" -ge 0 ]; }; then \
		echo "${GREEN}macOS version $$os_version is detected. Proceeding with the script.${RESET}"; \
	else \
		echo "${RED}This script is intended for macOS version 15.0 or higher.${RESET}"; \
		exit 1; \
	fi

	@echo "${BLUE}Checking adminPass is set...${RESET}"
	@if [ -z "$$adminPass" ]; then \
		echo "${RED}adminPass is not set. Please set it with 'export' before running the script.${RESET}"; \
		exit 1; \
	fi

	@echo "${BLUE}Checking serverAdminPass is set...${RESET}"
	@if [ -z "$$serverAdminPass" ]; then \
		echo "${RED}serverAdminPass is not set. Please set it with 'export' before running the script.${RESET}"; \
		exit 1; \
	fi

xcode:
	@xcode_installed=$$(xcode-select -p); \
	if [ ! -e "$$xcode_installed" ]; then \
		echo "${BLUE}Installing xcode...${RESET}"; \
		xcode-select --install > /dev/null; \
		echo "${GREEN}xcode is installed.${RESET}"; \
	fi

brew:
	@echo "${BLUE}Installing brew...${RESET}"
	@curl -O -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
	@shpath="./install.sh"; \
	if [ ! -e "$$shpath" ]; then \
		echo "\n${RED}Could not find ${shpath}!${RESET}"; \
		exit 1; \
	fi; \
	chmod 755 $$shpath; \
	expect -c "\
	spawn bash $$shpath; \
	expect \"Password:\"; \
	send \"$(adminPass)\n\"; \
	expect \"Press RETURN/ENTER to continue or any other key to abort:\"; \
	send \"\r\"; \
	interact"; \
	rm -f $$shpath
	@chmod 755 /opt/homebrew/share
	@echo >> ${HOME}/.zprofile; \
	echo 'export PATH="/opt/homebrew/bin:$$PATH"' >> ${HOME}/.zprofile; \
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ${HOME}/.zprofile; \
	eval "$$(/opt/homebrew/bin/brew shellenv)"

bundle:
	@echo "${BLUE}Executing brew bundle...${RESET}"
	@expect ./brew_bundle.exp

defaults:
	@echo "${BLUE}Configuring defaults...${RESET}"
	@chmod 755 defaults.sh; \
	./defaults.sh > /dev/null

azcompletion:
	@echo "${BLUE}Installing az completion...${RESET}"
	@mkdir ${HOME}/.azure; \
	curl -o ${HOME}/.azure/az.completion https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion

duti:
	@echo "${BLUE}Setting default app for files...${RESET}"
	@for ext in txt py xml sh md json csv; do \
	/opt/homebrew/bin/duti -s dev.zed.Zed $$ext all; \
	done

zed_settings:
	@echo "${BLUE}Configuring zed settings...${RESET}"
	@mkdir -p ${HOME}/.config/zed/; \
	cp -f ./config/zed/settings.json ${HOME}/.config/zed/settings.json

copy_configs:
	@cp -f config/Rectangle/com.knollsoft.Rectangle.plist ${HOME}/Library/Preferences/com.knollsoft.Rectangle.plist
	@osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Rectangle.app", hidden:false}'
	@cp -f config/Terminal/com.apple.Terminal.plist ${HOME}/Library/Preferences/com.apple.Terminal.plist
	@cp -f config/Dock/com.apple.dock.plist ${HOME}/Library/Preferences/com.apple.dock.plist

zprofile:
	@echo "${BLUE}Linking zprofile...${RESET}"
	@rm -f ${HOME}/.zprofile; \
	ln -s ${HOME}/Library/Mobile Documents/com~apple~CloudDocs/zprofile ${HOME}/.zprofile

sshkeygen:
	@echo "${BLUE}Generating SSH key and share it with servers...${RESET}"
	@chmod 755 ssh.exp; \
	expect ssh.exp

folderaction:
	@echo "${BLUE}Configuring Folder Action...${RESET}"
	@cp -r ./Workflows/ ${HOME}/Library/Workflows/
	@chmod 755 ${HOME}/owncloud/bin/rename.sh
	@osascript fa.scpt

manual_configs:
	@echo "${BLUE}Opening todo.txt...${RESET}"
	@open todo.txt
	@open /Applications/owncloud.app
