# Define the number of master and worker nodes
NUM_MASTER_NODE = 1
NUM_WORKER_NODE = 2

IP_NODES = "192.168.56."
MASTER_NODE_IP = "192.168.56.2"

MASTER_IP_START = 1
NODE_IP_START = 2

Vagrant.configure("2") do |config|

    # Box Settings
    config.vm.box = "ubuntu/focal64"
    config.vm.box_check_update = true

    (1..NUM_MASTER_NODE).each do |i|
        config.vm.define "kubemaster" do |node|
            node.vm.provider "virtualbox" do |vb|
                # Name shown in the GUI
                vb.name = "kubemaster"
                vb.memory = 2048
                vb.cpus = 2
            end
            node.vm.hostname = "kubemaster"
            # Network Settings
            node.vm.network :private_network, ip: IP_NODES + "#{MASTER_IP_START + i}"
            node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"

            # Provision Settings
            # node.vm.provision "setup-hosts", :type => "shell", :path => "utils/ubuntu/setup-hosts.sh" do |s|
            #     s.args = ["wlp3s0"]
            # end
            # # Provision Settings
            # node.vm.provision "setup-dns", :type => "shell", :path => "utils/ubuntu/update-dns.sh"
            
            # Provision Docker 
            node.vm.provision "Install Docker", :type => "shell", :path => "utils/ubuntu/install-docker.sh"

            # Provision Kubernetes 
            node.vm.provision "Install Kubernetes", :type => "shell", :path => "utils/kubernetes/install-master-node.sh" do |s|
                s.args = ["#{MASTER_NODE_IP}"]
            end
        end
    end
end