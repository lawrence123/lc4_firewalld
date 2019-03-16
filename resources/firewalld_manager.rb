# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
property :portnumber, String, name_attribute: true
property :service_name, String, name_attribute: true
property :protocol, String
property :description, String


resource_name 'firewalld_manager'

default_action :addport

action :addport do
  execute 'add service to firewalld' do
    command "firewall-cmd --permanent --add-port=#{new_resource.portnumber}"
    action :run
    not_if { "firewall-cmd --zone=public --list-ports | grep #{new_resource.portnumber}" }
  end
end
action :reload do
  execute 'Reload firewalld' do
    command 'firewall-cmd --reload'
    action :run
  end
end
action :addservice do
  template "/etc/firewalld/services/#{new_resource.service_name}.xml" do
    source 'service.xml.erb'
    mode '0644'
    variables(serivce_name: new_resource.service_name,
              protocol: new_resource.protocol,
              portnumber: new_resource.portnumber,
              description: new_resource.description)
    not_if File.exist?("/etc/firewalld/services/#{new_resource.service_name}.xml")
  end

  execute 'Add service to firewalld' do
    command "firewall-cmd --permanent --add-service=#{new_resource.service_name}"
    action :run
    not_if { "firewall-cmd --zone=public --list-services | grep #{new_resource.service_name}"}
    not_if { "firewall-cmd --zone=public --list-ports | grep #{new_resource.portnumber}" }
  end
end
