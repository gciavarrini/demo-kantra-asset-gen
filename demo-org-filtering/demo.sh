#!/bin/bash

# Include the "demo-magic" helpers
source ../scripts/demo-magic.sh

PS1="➜ "

DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TYPE_SPEED=25
PROMPT_TIMEOUT=8
DEMO_COMMENT_COLOR=$PURPLE
SHOW_CMD_NUMS=true

function comment() {
cmd=$DEMO_COMMENT_COLOR$1$COLOR_RESET
echo -en "$cmd"; echo ""
}

function note() {
  cmd="${GREEN}${1}${COLOR_RESET}"
  printf "%b\n" "$cmd"
}

clear

DEMO_DIR=$(pwd)
rm -rf /tmp/kantra/
rm -rf /tmp/output-dir
mkdir /tmp/output-dir

wait
comment "# Kantra CLI - Organization Filtering Demo"
comment "# This demo showcases the new organization filtering feature for Cloud Foundry discovery"
wait

comment "\n# Clone the Kantra repository"
git clone -q git@github.com:konveyor/kantra.git /tmp/kantra 
cd /tmp/kantra 

comment "\n# Checkout the organization filtering PR"
gh pr checkout 587 &> /dev/null

comment "\n# Build the project"
go build &> /dev//null

# wait
comment "\n# Prerequisites:"
comment "# - Ensure your Cloud Foundry config is in /tmp/.cf/config.json"
wait 

comment "\n# =========================================="
comment "# Scenario 1: List ALL apps from ALL organizations"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --list-apps"
wait

clear

comment "\n# =========================================="
comment "# Scenario 2: Discover all apps from all spaces in specified orgs"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=org,testorg --list-apps"
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=org,testorg"
wait

note "\n# Note: Only apps from 'org' and 'testorg' are listed"
note "# All spaces within these organizations are included"
wait

clear

comment "\n# =========================================="
comment "# Scenario 3: Warn if a space doesn't exist in the organization"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=testorg --spaces=space,nonexistent --list-apps"
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=testorg --spaces=space,nonexistent"
wait

note "\n# Note the warning: 'Skipping space because it doesn't exist in this organization'"
note "# Discovery continues with the spaces that do exist"
wait

clear

comment "\n# =========================================="
comment "# Scenario 4: Discover from multiple orgs with space filter"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=org,testorg --spaces=space,dylan --list-apps"
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=org,testorg --spaces=space,dylan"
wait

note "\n# Note:"
note "# - 'space' exists in both 'org' and 'testorg': apps from both are listed"
note "# - 'dylan' exists only in 'testorg': warning for org, apps listed for testorg"
wait

clear

comment "\n# =========================================="
comment "# Scenario 5: Invalid organization names"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=nonexistent,testorg --list-apps"
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=nonexistent,testorg"
wait

note "\n# Discovery proceeds with valid orgs and logs info about invalid ones"
wait

clear

comment "\n# =========================================="
comment "# Scenario 6: Discover a specific application (org + space + app name)"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=testorg --spaces=space --app-name=java-backend-2"
wait

note "\n# Only the specified application was discovered"
wait

clear

comment "\n# =========================================="
comment "# Scenario 7: Full discovery with organization filter"
comment "# Save discovery manifests for filtered organizations"
comment "# =========================================="
wait
pei "./kantra discover cloud-foundry --use-live-connection --cf-config=/tmp/ --orgs=org,testorg --output-dir /tmp/output-dir/"
wait

pei "tree /tmp/output-dir/"
wait
