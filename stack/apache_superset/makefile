superset-setup:
	@helm repo add superset https://apache.github.io/superset

superset-pull-chart:
	@helm pull superset/superset --version 0.15.0 --untar

# superset-port-forward:
# 	kubectl port-forward superset-xxxx-yyyy :8088

superset-deploy:
	echo $(FOLDER_PROJECT)
	helm upgrade --install --values $(FOLDER_PROJECT)/stack/apache_superset/values.yaml superset superset/superset
