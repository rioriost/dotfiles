#!/bin/zsh

defaults_domain="com.apple.screencapture"

# Read screenshot settings
screenshot_location=$(defaults read ${defaults_domain} location -string)
screenshot_prefix=$(defaults read ${defaults_domain} name)
screenshot_type=$(defaults read ${defaults_domain} type -string)

# Get list of screenshot files
list=("${screenshot_location}/${screenshot_prefix}"*."${screenshot_type}")

# Iterate over each screenshot file
for fpath in "${list[@]}"; do
    fname=$(basename "${fpath}")
    dname=$(dirname "${fpath}")

    # Extract date and time from the filename
    if [[ "${fname}" =~ ${screenshot_prefix}\ ([0-9]{4})-([0-9]{2})-([0-9]{2})\ ([0-9]{1,2})\.([0-9]{2})\.([0-9]{2})\.${screenshot_type} ]]; then
        yyyymmdd="${match[1]}${match[2]}${match[3]}"
        hhmmss=$(printf "%02d" ${match[4]})${match[5]}${match[6]}

        # Rename the file
        mv "${fpath}" "${dname}/${yyyymmdd}${hhmmss}.${screenshot_type}"
    fi
done
