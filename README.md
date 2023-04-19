# Kubernetes_Installation
Install kubernetes without any error

##Prerequirments
One or more machines running a deb/rpm-compatible Linux OS; for example: Ubuntu or CentOS.
2 GiB or more of RAM per machine
2 CPUs on the machine that you use as a control-plane node.
take the SSH for 

Step 1. #so this step master and worker node

sudo -i
mkdir projects
cd projects
git clone https://github.com/mahenmeena/Kubernetes_Installation.git
ls -la
chmod +x k8s-install.sh
./k8s-install.sh   #run the shell script for the cluser setup

Step 2. ##run the kubeadm init only on master node

kubeadm init --pod-network-cidr=10.244.0.0/16

Step 3. ##read and run the output 

Your Kubernetes control-plane has initialized successfully!

##To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

##You should now deploy a Pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  /docs/concepts/cluster-administration/addons/

##You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>

