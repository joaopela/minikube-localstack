# minikube-localstack
Local stack for kubernetes on Minikube. Testing things like airflow and other data stack tools.

Assuming you are running in Ubuntu 24.04 LTS or later versions of the OS. Or the equivalent version of Ubuntu within Windows WSL sub-system.

A makefile is provided to make life easy with all steps, including installing:
* Docker
* kubectx 
* kubectl
* k9s
* Minikube 

```bash
sudo apt install make
make install
```
