#!/bin/bash

# Include the "demo-magic" helpers
source ../scripts/demo-magic.sh

# PS1='➜ '
DEMO_PROMPT="➜ "

DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TYPE_SPEED=25
PROMPT_TIMEOUT=5
DEMO_COMMENT_COLOR=$PURPLE
SHOW_CMD_NUMS=true

function comment() {
  cmd=$DEMO_COMMENT_COLOR$1$COLOR_RESET
  echo -en "$cmd"; echo ""
}

clear

DEMO_DIR=$(pwd)
rm -rf /tmp/kantra/
rm -rf /tmp/output-dir
rm -rf /tmp/.cf
mkdir /tmp/output-dir

wait
comment "# Kantra CLI - Live Discover Demo"
comment "# This demo walks through the 'discover' subcommand and explains how to perform a live discover"
wait

# # comment "\n# Clone the Kantra repository since the functionality is still in a PR."
git clone -q git@github.com:konveyor/kantra.git /tmp/kantra 
cd /tmp/kantra 

# # comment "\n# Checkout the asset generation PR."
gh pr checkout 505 &> /dev/null

# # comment "\n# Build the project"
go build &> /dev//null

# comment "\n# First, follow this guide"
# comment "# https://github.com/konveyor/asset-generation/blob/main/docs/deploying-cf-locally.md#connect-to-a-remote-cloud-foundry-instance"
# comment "# to set up your local environment."
# comment "# Once you can connect to the remote Cloud Foundry instance, we can start the live discover."

wait
comment "\n# Investigate the remote Cloud Foundry instance"
pei 'cf spaces'
wait

comment "\n# Inspect the space: \"space\""
pei 'cf target -o org -s space'
pei 'cf apps'
comment "# Two applications are available: nginx and test-app"
wait

comment "\n# Inspect the space: \"space-2\""
pei 'cf target -o org -s space-2'
pei 'cf apps'
comment "# One application is available: test-app"
wait

comment "\n# Now let's focus on Kantra CLI's 'Live Discover' feature"
wait

comment "\n# Copy the remote CF config file, locally"
pei 'mkdir /tmp/.cf'
pei 'scp guest@helios02.lab.eng.tlv2.redhat.com:~/.cf/config.json /tmp/.cf'
wait 

comment "\n# Review available flags for the discover command"
pei './kantra discover cloud-foundry -h'
wait

comment "\n# Run live discovery with the selected spaces and save the output"
comment "# Since the CF config is not located in the default '~/.cf' path, we specify its directory explicitly"
pei './kantra discover cloud-foundry --use-live-connection --spaces=space,space-2 --output-dir /tmp/output-dir/live-discover --cf-config=/tmp/ --skip-ssl-validation=true'
wait 

pei 'tree /tmp/output-dir/live-discover'
wait

pei 'cat /tmp/output-dir/live-discover/discover_manifest_space_nginx.yaml'
wait
pei 'cat /tmp/output-dir/live-discover/discover_manifest_space_test-app.yaml'
wait 
pei 'cat /tmp/output-dir/live-discover/discover_manifest_space-2_test-app.yaml'

comment "\n# We can run live discover on a specific application"
pei './kantra discover cloud-foundry --use-live-connection --app-name=nginx --spaces=space,space-2 --output-dir /tmp/output-dir/live-discover-nginx  --cf-config=/tmp/ --skip-ssl-validation=true'
wait 

pei 'tree /tmp/output-dir/live-discover-nginx'
wait

