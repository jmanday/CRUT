VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box     = 'azure'
  config.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

  config.ssh.username         = 'vagrant'

  config.vm.provider :azure do |azure|
    azure.mgmt_certificate = File.expand_path('~/.ssh/azurevagrant.key')
    azure.mgmt_endpoint = 'https://management.core.windows.net'
  
    azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

    azure.storage_acct_name = '' 

    azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
    
    azure.vm_user = 'vagrant' 
    azure.vm_password = 'vagrant123#@!' 

    azure.vm_name = 'azure-vagrant' 
    azure.cloud_service_name = '' 

    azure.vm_location = 'North Europe'

    azure.tcp_endpoints = '3389:53389' 
    azure.winrm_https_port = 5986
    azure.ssh_port = '22'
  
    azure.winrm_transport = %w(https)
  end
  
    config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
  
end
