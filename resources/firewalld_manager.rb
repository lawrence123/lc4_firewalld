# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
property :portnumber, String, name_attribute: true

resource_name 'firewalld_manager'

default_action :create

action :create do
  execute 'add service to firewalld' do
    command "firewall-cmd --permanent --add-port=#{new_resource.portnumber}"
    action :run
    not_if "firewall-cmd --zone=public --list-ports | grep #{new_resource.portnumber}"
  end
end
action :reload do
  execute 'Reload firewalld' do
    command 'firewall-cmd --reload'
    action :run
  end
end
