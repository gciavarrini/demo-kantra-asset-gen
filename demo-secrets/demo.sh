#!/bin/bash

# Include the "demo-magic" helpers
source ../scripts/demo-magic.sh

# PS1='➜ '
DEMO_PROMPT="➜ "

DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TYPE_SPEED=30
PROMPT_TIMEOUT=6
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
mkdir /tmp/output-dir
clear
wait
comment "# Kantra CLI – Conceal Sensitive Information Demo"
comment "# Learn how Kantra CLI discover subcommand can identify and conceal sensitive information in a CloudFoundry manifest."
wait

comment "\n#  Clone the Kantra repository since the functionality is still in a PR."
git clone -q git@github.com:konveyor/kantra.git /tmp/kantra 
cd /tmp/kantra 

comment "\n# Checkout the asset generation PR."
gh pr checkout 505 &> /dev/null

comment "\n# Build the project"
go build &> /dev/null

comment "\n#  Inspect the available flags"
pei './kantra discover cloud-foundry -h'
wait
wait

cp $DEMO_DIR/app-with-secrets.yml /tmp/kantra

comment "\n# Let's start with a Cloud Foundry manifest that contains sensitive data"
pei 'cat app-with-secrets.yml'
wait

comment "\n\n# Run discovery and save the output"
comment "# Note: '--conceal-sensitive-data=false' is the default behavior"
comment "# We're setting it explicitly here for clarity in this demo"
pei './kantra discover cloud-foundry --conceal-sensitive-data=false --input ./app-with-secrets.yml --output-dir /tmp/output-dir/with-secrets'
wait 

pei 'tree /tmp/output-dir/with-secrets'
wait

pei 'cat /tmp/output-dir/with-secrets/discover_manifest_app-with-secrets.yaml'
wait

comment "\n# Now run discovery with '--conceal-sensitive-data=true'"
comment "# This will extract and replace sensitive values with UUID references"
pei './kantra discover cloud-foundry --conceal-sensitive-data=true --input ./app-with-secrets.yml --output-dir /tmp/output-dir/with-secrets-conceal'
wait 

pei 'tree /tmp/output-dir/with-secrets-conceal'
wait

pei 'cat /tmp/output-dir/with-secrets-conceal/discover_manifest_app-with-secrets.yaml'
wait

comment "\n# Compare the outputs side by side:"
pei 'diff -y /tmp/output-dir/with-secrets/discover_manifest_app-with-secrets.yaml /tmp/output-dir/with-secrets-conceal/discover_manifest_app-with-secrets.yaml | colordiff'
comment "# You'll notice that sensitive values have been replaced with UUID placeholders"
wait 

comment "\n# Now inspect the secrets map"
pei 'cat /tmp/output-dir/with-secrets-conceal/secrets_app-with-secrets.yaml'
comment "# This file contains the mapping of UUIDs to the actual sensitive values"
wait