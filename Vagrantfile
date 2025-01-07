NUM_MASTER_NODE = 2
NUM_WORKER_NODE = 2

IP_NW = "192.168.56."
MASTER_IP_START = 10
NODE_IP_START = 20

Vagrant.configure("2") do |config|
  config.vm.box = "alvistack/ubuntu-24.04"
  config.vm.box_version = "20250103.1.1"
  config.vm.box_check_update = false

  # Define master nodes
  (1..NUM_MASTER_NODE).each do |i|
    config.vm.define "master-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "master-#{i}"
        vb.memory = 2048
        vb.cpus = 2
      end
      node.vm.hostname = "master-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
    end
  end

  # Define worker nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "worker-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "worker-#{i}"
        vb.memory = 2048
        vb.cpus = 2
      end
      node.vm.hostname = "worker-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
    end
  end

  config.vm.provision :ansible do |ansible|
      ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/init_k8s.yaml"
    ansible.limit = "all"
  end
end
