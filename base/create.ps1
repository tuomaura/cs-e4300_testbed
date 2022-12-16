# 1. Do this first in elevated PowerShell and reboot if necessary:
# Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
# 2. Make sure the files are on a local file system, not in the cloud.

vagrant destroy -f base
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
vagrant box remove base
vagrant up base --provision
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
vagrant vbguest base --status
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
vagrant package --output ../base.box
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
vagrant box add base ../base.box -f
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
vagrant destroy -f base
if (-not $?) {throw 'Failed in: '+(Get-History -Count 1).CommandLine}
Remove-Item -Recurse -Force .vagrant
