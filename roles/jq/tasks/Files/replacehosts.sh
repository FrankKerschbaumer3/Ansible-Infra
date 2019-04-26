#!/bin/sh/
a="$(aws cloudformation describe-stacks --stack-name single-instance | jq -r '.Stacks[0] | .Outputs[] | select(.OutputKey == "PublicDNS") | .OutputValue')"
hosts="/etc/ansible/hosts"

if [ -z "$a" ]; then
    echo "Invalid output, exiting"
    exit 1
else
    echo "Replacing ec2 instance DNS name in ansible hosts"
    sudo sed -i '' "5s/.*/$a/" "$hosts"
fi