#!/bin/sh

root_path="."
config_directory="${HOME}/.config/nvim"
lua_directory="${config_directory}/lua"
files_path="${root_path}/files"

# Create config directory
if [ ! -d ${config_directory} ]; then
	mkdir ${config_directory}
	echo "Configuration path created"
else
	echo "Configuration path already created"
fi

# Clone package manager: Packer
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
	echo "Packer already cloned"
fi

# Create folder structure
if [ ! -d ${lua_directory} ]; then
	mkdir ${lua_directory}
	echo "Lua path created"
else
	echo "Lua path already created"
fi

# Copy init.lua
cp ${files_path}/init.lua ${config_directory}/.

# Copy plugins.lua
cp ${files_path}/plugins.lua ${lua_directory}/.

# Copy settings.lua
cp ${files_path}/settings.lua ${lua_directory}/.

# Install packages
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
