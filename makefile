include /etc/os-release

include stack/minikube/makefile
include stack/apache_superset/makefile

# Make flags
MAKEFLAGS += --no-print-directory

# Folders absolute path
FOLDER_PROJECT := $(shell pwd)
FOLDER_DEPLOYMENT := $(FOLDER_PROJECT)/deployment

ARCH := $(shell dpkg --print-architecture)

install-docker:
	# Add Docker's official GPG key:
	sudo apt update
	sudo apt install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	"deb [arch=$(ARCH) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	$(UBUNTU_CODENAME) stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	# Adding used to docker group	
	sudo usermod -aG docker $(USER) && newgrp docker

install-kubectl:
	sudo snap install --classic kubectl

install-kubectx:
	sudo apt install kubectx

install-k9s:
	sudo snap install k9s --channel=latest/stable
	sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/k9s

install-minikube:
	curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

install-helm:
	sudo snap install --classic helm

local-stack-create-folders:
	@echo "[local-stack-create-folders] Starting..."
	@mkdir -p $(FOLDER_DEPLOYMENT)
	@echo "[local-stack-create-folders] Done!"

install:
	make install-docker
	make install-kubectl
	make install-kubectx
	make install-k9s
	make install-minikube
	make install-helm
	make local-stack-create-folders

local-stack-deploy:
	@echo "[local-stack-deploy] Deploying..."

	@echo $(FOLDER_PROJECT)

	@echo "[local-stack-deploy] Printing all variables."
	@make minikube-variables

	@echo "[local-stack-deploy] Starting Deployment..."
	@make minikube-start

	@echo "[local-stack-deploy] Starting Apache Superset..."
	@make superset-deploy

local-stack-remove:
	@echo "[local-stack-remove] Removing the local deployment..."
	@make minikube-remove
