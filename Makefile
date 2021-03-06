SHELL = /bin/bash

.PHONY: help
help: ## Display this text
	@grep -E '^[a-zA-Z_-]+[%]?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: sshkeys
sshkeys: ## Generate ssh keys for servers
	test -d temp || ( mkdir temp; ssh-keygen -t rsa -f ./temp/sshkey -q -N "" )

.PHONY: build-%
build-%: sshkeys ## Build VMs with config from build-**folder_name**
	cd $* \
	&& sudo vagrant up; \
	sudo vagrant status

.PHONY: destroy-%
destroy-%: ## Destroy VMs with config from destroy-**folder_name**
	cd $* \
	&& sudo vagrant destroy --force

.PHONY: ssh-%
ssh-%: ## SSH to vm by vm name. Example: make ssh-k8s_vms vm=controleplain
	cd $* \
	&& sudo vagrant ssh $(vm)

.PHONY: halt-%
halt-%: ## Poweroff vms in folder. Example: make halt-k8s_vms
	cd $* \
	&& sudo vagrant halt

.PHONY: snap-%
snap-%: ## Create snapshot for all vms in folder
	cd $* \
	&& sudo vagrant snapshot push

.PHONY: restore-%
restore-%: ## Restore to the snapshot all vms in folder
	cd $* \
	&& sudo vagrant snapshot pop --no-delete
