# Kubernetes options
KUBERNETES_VERSION := 1.33.1

# Minikube options
MINIKUBE_MEMORY := 8192
MINIKUBE_CPUS := 8

minikube-variables:
	@echo "[minikube-variables] MINIKUBE_CPUS      : $(MINIKUBE_CPUS)"
	@echo "[minikube-variables] MINIKUBE_MEMORY    : $(MINIKUBE_MEMORY)"
	@echo "[minikube-variables] KUBERNETES_VERSION : $(KUBERNETES_VERSION)"

minikube-setup:
	@echo "[minikube-setup] Setting up Minikube Docker environment..."
	@eval $(minikube -p minikube docker-env)

minikube-start:
	@echo "[minikube-start] Starting ..."
	make minikube-setup

	minikube start \
		--driver=docker \
		--cpus=$(MINIKUBE_CPUS) \
		--memory=$(MINIKUBE_MEMORY) \
		--kubernetes-version=$(KUBERNETES_VERSION) \
		--mount \
		--mount-string="$(FOLDER_DEPLOYMENT):/mnt/data" \
		--embed-certs \
		--extra-config=apiserver.service-node-port-range=30000-32767 \
		--extra-config=kubelet.node-ip=0.0.0.0

	@echo "[minikube-start] Done!"

minikube-remove:
	@echo "[minikube-remove] Starting ..."
	minikube stop
	minikube delete
	@echo "[minikube-remove] Done ..."
