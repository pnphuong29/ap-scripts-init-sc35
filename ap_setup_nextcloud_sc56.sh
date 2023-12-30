# Notes
# - This script should be used to setup Ubuntu Server >= 22.04
# Usage
# - Download this script into any location owned by current user
# - Run the command `source script_file_name.sh`

ap_setup_bash() {
	# Download bash source code
	ap_bash_version='5.1.16'
	cd ~/Download
	curl -LO "https://mirror.downloadvn.com/gnu/bash/bash-${ap_bash_version}.tar.gz"
	tar -zxf "bash-${ap_bash_version}.tar.gz"

	# Install bash
	export AP_VENDORS_BASH_DIR="${HOME}/pnphuong29/software/bash/bash-${ap_bash_version}"
	cd "bash-${ap_bash_version}"
	./configure --prefix="${AP_VENDORS_BASH_DIR}"
	make install

	sudo echo "${AP_VENDORS_BASH_DIR}/bin/bash" >>/etc/shells
	chsh -s "${AP_VENDORS_BASH_DIR}/bin/bash"
}

# @#bashsn $$ measure execution time
TIMEFORMAT="It took [%R] seconds to execute this script"
time {
	# Install essential and required apps
	echo "Installing essential and required apps"
	sudo add-apt-repository -y ppa:git-core/ppa

	sudo apt update
	sudo apt install -y git wget curl vim ssh

	# If current bash version < 5.x then uncomment the below lines to install bash
	# ap_setup_bash()

	curl -SsL "https://raw.githubusercontent.com/pnphuong29/ap-scripts-init-sc35/master/ap_ssh.config" >~/.ssh/config
	chmod 600 ~/.ssh/config
	chmod 600 ~/.ssh/authorized_keys

	export AP_GH_P29_DIR="${HOME}/pnphuong29/projects/github.com/pnphuong29"
	mkdir -p "${AP_GH_P29_DIR}"

	# SC28
	export AP_PRJ_SC28_DIR="${AP_GH_P29_DIR}/ap-scripts-common-sc28"
	rm -rf "${HOME}/scripto-common"
	cd "${AP_GH_P29_DIR}"
	git clone https://github.com/pnphuong29/ap-scripts-common-sc28.git
	# git clone "git@github.com:pnphuong29/ap-scripts-common-sc28.git"

	# SC56
	ap_prj_scripts_name="ap-scripts-nextcloud-sc56"
	export AP_PRJ_SCRIPTS_DIR="${AP_GH_P29_DIR}/${ap_prj_scripts_name}"
	rm -rf "${HOME}/scripto-main"
	cd "${AP_GH_P29_DIR}"
	git clone https://github.com/pnphuong29/ap-scripts-nextcloud-sc56.git
	# git clone "git@github.com:pnphuong29/${ap_prj_scripts_name}.git"

	# Setup apps
	echo "Installing vendors"
	source "${HOME}/scripto-main/ap_setup_vendors.sh"
	source "${HOME}/scripto-main/ap_master.sh"

	echo "time source /home/vagrant/pnphuong29/projects/github.com/pnphuong29/ap-scripts-nextcloud-sc56/ap_master.sh" >>~/.bashrc
}
