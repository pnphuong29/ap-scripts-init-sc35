TIMEFORMAT="It took [%R] seconds to execute this script"
time {
	source <(curl https://raw.githubusercontent.com/pnphuong29/ap-scripts-public-sc35-pub7/master/ap_init.sh)

	ap_prj_scripts_name="ap-scripts-pc7-sc21"
	export AP_PRJ_SCRIPTS_DIR="${AP_GH_PNP29_DIR}/${ap_prj_scripts_name}"
	echo "${AP_PRJ_SCRIPTS_DIR}"
	rm -rf "${AP_PRJ_SCRIPTS_DIR}"
	cd "${AP_GH_PNP29_DIR}"

	git clone "https://github.com/pnphuong29/${ap_prj_scripts_name}.git"
	source "${AP_PRJ_SCRIPTS_DIR}/ap_setup_vendors.sh"
}
