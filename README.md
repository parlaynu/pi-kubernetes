# Kubernetes Cluster on Raspberry Pi

This project creates a kubernetes cluster on Raspberry Pi servers. I use if for learning and experimenting
rather than hosted services as there is no magic happening under the hood that you can't access.

The setup uses `keepalived` and `haproxy` even in a single controller configuration. With multiple controllers,
the configurations of these services are modified to support multiple controllers.

The minimum cluster size is two nodes - one controller and one worker.

This is based on instructions from here:

    https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

## Hardware and Software

* 3x RaspiberryPi 4 8GByte
* Ubuntu Server 22.04.1 LTS (64 bit)
* Kubernetes v1.25.3
* Terraform v1.3.2
* Ansible [core 2.13.5]

## System Setup

Install the OS image using the Imager tool from [here](https://www.raspberrypi.com/software/).

Once you have it downloaded:

* choose the OS as 'Ubuntu Server 22.04.1 LTS (64 bit)'
* set the username/password and ssh public key information in the settings
* write to the SD disk

Connect the servers to a wired network and start them all. Once they are all up and you can ssh into
them, it's time for the next step.

## Configure

### Terraform

Terraform is used to build the ansible configurations.

Copy the file `terraform.tfvars.example` to `terraform.tfvars` and configure to match your installation.

Then run:

    terraform init
    terraform apply

### Ansible

The ansible scripts are ready to run at this point.

    ./local/ansible/run_ansible.sh

Once this completes, you should have a working kubernetes cluster with the dashboard installed.

Note that it can take some time from when ansible finishes to when the cluster is ready.

## Kubectl Setup

Copy the kubectl config file from the crontroller at `/root/.kube/config` file to your local machine
at `~/.kube/config`.

This allows you to run kubectl commands locally. Test with:

    kubectl get nodes
    kubectl get pods --all-namespaces


## Connect To Dashboard

Documentation on the dashboard and setup can be found [here](https://github.com/kubernetes/dashboard).

Most of the setup is completed by ansible except for the few manual steps to follow below.

Create a token to login with. You will need this once you connect to the service.

    kubectl -n kubernetes-dashboard create token admin-user

Start the proxy:

    kubectl proxy

Browse to dashboard:

    http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

