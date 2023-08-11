# vagrant
Vagrant templates for VMs

## Pre-setup steps
- Virtualbox should be installed (usually with apt)

## Setup required virtual environment
To set up use make with folder name: make build-**app_folder_name**. Example:
``` make build-gitlab ``` 
This script will automatically create temp/ directory with ssh keys in project home directory. All of created VMs will have these keys in .ssh and authorized_keys.

## Destroy virtual environment
To destroy your virtual environment use male destroy-**app_folder_name**. Example:
``` make destroy-gitlab ```
