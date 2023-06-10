machines = [
  {
    "name" => "vm01", 
    "image" => "geerlingguy/centos7", \
    "hostname" => "master", 
    "cpus" => "1", 
    "mem" => "1024", 
    "ip" => "192.168.57.3", 
    "init_sh" => "master_init.sh",
    "mount_point" => "/vagrant_data"
  
  },

  {
    "name" => "vm02", 
    "image" => "geerlingguy/centos7", 
    "hostname" => "worker", 
    "cpus" => "1", 
    "mem" => "1024", 
    "ip" => "192.168.57.4", 
    "init_sh" => "worker_init.sh",
    "mount_point" => "/vagrant_data"

 }
]


# system("if [ -d 'data' ]; then rm -r data; fi && mkdir data" )

Vagrant.configure("2") do |config|


  machines.each do |machine|
    config.vm.define machine["name"] do |config|
      

      config.vm.box = machine["image"]
      config.vm.hostname = machine["hostname"]
      config.vm.network "private_network", ip: machine["ip"]
      # config.vm.network "public_network", ip: "192.168.0.2"
      config.vm.synced_folder "./data",  machine["mount_point"]     
      # config.vm.synced_folder ".", machine["mount_point"], type: "nfs"
      # config.vm.synced_folder "./data", machine["mount_point"], type: "rsync"


      config.vm.provider "virtualbox" do |vb|
        vb.cpus = machine["cpus"]
        vb.memory = machine["mem"]
      end

      config.vm.provision :shell, :path => machine["init_sh"], :args => [machine["ip"], machine["mount_point"]+"/token"]

      #config.vm.provision "shell" do |shell|
      #  shell.path = machine["init_sh"]
      #  shell.args = [machine["ip"], machine["mount_point"]+"\token"]
      #end


    end
  end


end
