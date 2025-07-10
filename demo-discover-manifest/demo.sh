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
rm -rf /tmp/asset-generation
rm -rf /tmp/kantra/
rm -rf /tmp/output-dir
mkdir /tmp/output-dir


wait
comment "# Kantra CLI - Asset Generation Demo"
comment "# This demo walks through the 'discover' subcommand and explains the structure of the discover manifest."
wait

# comment "\n# Clone the Kantra repository since the functionality is still in a PR."
git clone -q git@github.com:konveyor/kantra.git /tmp/kantra 
cd /tmp/kantra 

# comment "\n# Checkout the asset generation PR."
gh pr checkout 505 &> /dev/null

# comment "\n# Build the project"
go build &> /dev/null

comment "\n# Let's focus on discover subcommand"
pei './kantra discover -h'
wait

comment "\n# Let's check the supported platforms"
pei './kantra discover --list-platforms'
wait

comment "\n# At the moment we only support cloud-foundry"
pei './kantra discover cloud-foundry -h'
wait

comment "\n# Let's focus on 'local' discover feature"
comment "# It requires as input mandatory parameter a cloud foundry application manifest."

cp $DEMO_DIR/app-with-inline-process-only-type.yml /tmp/kantra

comment "\n# Here's a sample input manifest:"
wait

comment "\n# Running the discover command with that input"
pei 'cat app-with-inline-process-only-type.yml'
wait

comment "\n# Run discovery with this new input and save the output"
pei './kantra discover cloud-foundry --input ./app-with-inline-process-only-type.yml --output-dir /tmp/output-dir/with-type'
wait 

pei 'tree /tmp/output-dir/with-type'
wait

comment "\n# Now we can use the generated canonical manifest as input for the generate command."
pei "./kantra generate -h"
wait

comment "\n# We only support helm at the moment"
pei './kantra generate helm -h'
wait 

cp -r $DEMO_DIR/helm_sample /tmp/kantra/helm_sample

comment "\n# We have a dummy Helm chart in this demo for demonstration purposes."
pei "tree helm_sample"

comment "\n# Let's take a look at some key files in the Helm chart."
pei "cat helm_sample/Chart.yaml"
wait
pei "cat helm_sample/templates/configmap.yaml"
wait

comment "\n# There is also a Dockerfile (non-k8s manifest)."
pei "cat helm_sample/files/konveyor/Dockerfile"
wait

comment "\n# Now, let's use the canonical manifest created by the 'discover' command (step n.17)"
comment "# to generate Helm template manifest."
pei "./kantra generate helm --chart-dir helm_sample --input cf-nodejs-app-canonical.yaml"
wait 

comment "\n# You can also store the resuls in a directory"
pei "./kantra generate helm --chart-dir helm_sample --input cf-nodejs-app-canonical.yaml --output-dir outDir"
wait

pei "ls outDir"
comment "\n# This is the generated configmap."
pei "cat outDir/configmap.yaml"
wait

comment "\n# This is the generated Dockerfile."
pei "cat outDir/Dockerfile"
wait

