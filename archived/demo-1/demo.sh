#!/bin/bash

# Include the "demo-magic" helpers
source ../scripts/demo-magic.sh

# PS1='➜ '
DEMO_PROMPT="➜ "

DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TYPE_SPEED=80
PROMPT_TIMEOUT=1
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

wait
comment "# Kantra CLI - Asset Generation Demo",
comment "# This demo shows how to use 'discover' and 'generate' subcommands."
wait

# comment "\n#  Clone the Kantra repository since the functionality is still in a PR."
git clone -q git@github.com:konveyor/kantra.git /tmp/kantra 
cd /tmp/kantra 

comment "\n# Checkout the asset generation PR."
gh pr checkout 435 &> /dev/null

# comment "\n# Build the project"
go build &> /dev/null

comment "\n#  Let's focus on discover subcommand"
pei './kantra discover -h'
wait

comment "\n#  Let's check the supported platforms"
pei './kantra discover --list-platforms'
wait

comment "\n#  At the moment we only support cloud-foundry"
pei './kantra discover cloud-foundry -h'
wait

comment "\n#  It requires as input mandatory parameter a cloud foundry application manifest."

cp $DEMO_DIR/cf-nodejs-app.yaml /tmp/kantra

comment "\n#  Let's use a sample one!"
pei 'cat ./cf-nodejs-app.yaml'
wait

comment "\n\n# After executing the discover command, we expect that the command prints the canonical manifest."
pei './kantra discover cloud-foundry --input ./cf-nodejs-app.yaml'
wait

comment "\n# ... But we can also write the output on a file"
pei './kantra discover cloud-foundry --input ./cf-nodejs-app.yaml --output cf-nodejs-app-canonical.yaml'
wait 

pei 'cat  cf-nodejs-app-canonical.yaml'
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
