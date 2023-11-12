#!/bin/sh

# Neovim details
# If Neovim stable updates then change these values
nvim_url="https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz"
nvim_version="9.4"
nvim_checksum="dbf4eae83647ca5c3ce1cd86939542a7b6ae49cd78884f3b4236f4f248e5d447"

# Folder details
root_path="."
artifacts_path="${root_path}/artifacts"
target_path="${artifacts_path}/nvim-linux64.tar.gz"

font_path="${artifacts_path}/Hack.zip"
fonts_dir="/usr/share/fonts"


# Start script
echo "Installing Neovim version $nvim_version"

# Create artifacts directory
if [ ! -d ${artifacts_path} ]; then
	mkdir ${artifacts_path}
	echo "Artifacts path created"
else
	echo "Artifacts path already created"
fi

# Download latest nvim
if [ ! -f ${target_path} ]; then
	wget ${nvim_url} -O ${target_path}
else
	echo "Nvim tar file already exists here: $target_path"
fi

# Download patched font
if [ ! -f $font_path ]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O $font_path
fi

if [ ! -d ${fonts_dir}/Hack ]; then
    sudo mkdir ${fonts_dir}/Hack
    sudo unzip $font_path -d $fonts_dir/Hack

    # Update font cache
    sudo fc-cache -fv

    echo "Font ${font_path} extracted to ${fonts_dir}"
else
    echo "Font ${font_path} already extracted to ${fonts_dir}"
fi


# Verify checksum
file_checksum=`sha256sum ${target_path} | awk '{print $1}'`

if [ $nvim_checksum = $file_checksum ]; then
	echo "Valid checksum"
else
	echo "Invalid checksum"
	echo "- Removing ${target_path} file..."
	rm -f $target_path
	echo "- File removed"
	exit 0
fi

# Extract tar file
tar -xzf ${target_path} -C ~/.local/share

if [ ! -d ~/.local/share/nvim-linux64 ]; then
	echo "Could not extract folder"
	exit 0
else
	echo "Nvim tar extracted to ~/.local/share/nvim-linux64"
fi

# Add link to binary
# Installation is performed only for the user running the script

if [ ! -f ~/.local/bin/nvim ]; then
	ln -s ~/.local/share/nvim-linux64/bin/nvim ~/.local/bin/nvim
	echo "Link created to binary in ~/.local/bin"
else
	echo "Binary link already created here: ~/.local/bin/nvim"
fi


# Add link to binary using global access
# Installation is performed for all users

if [ ! -f /bin/nvim ]; then
	sudo ln -s ~/.local/share/nvim-linux64/bin/nvim /bin/nvim
	echo "Link created to binary in /bin"
else
	echo "Binary link already created here: /bin/nvim"
fi









