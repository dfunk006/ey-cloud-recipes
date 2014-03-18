#
# Cookbook Name:: nginx_conf
# Recipe:: default
#

service "nginx" do
  supports :restart => true
  action :enable
end

if ['app_master', 'app', 'util', 'solo'].include?(node[:instance_role])
  node[:applications].each do |app, data|
    template "/etc/nginx/servers/bfwa.conf" do
      source 'nginx_app_conf.erb'
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      notifies :restart, resources(:service => 'nginx')
    end
  end
end