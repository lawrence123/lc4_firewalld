# lc4_firewalld



Usage

Create a port definition for the public zone

```ruby
firewalld_manager '8080/tcp' do
  action :create
end
```
Performs a firewall-cmd --reload

```ruby
firewalld_manager 'reload' do
  action :reload
end
```
