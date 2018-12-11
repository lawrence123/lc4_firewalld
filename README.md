# lc4_firewalld

Usage

firewalld_manager '8080/tcp' do
  action :create
end

firewalld_manager 'reload' do
  action :reload
end

