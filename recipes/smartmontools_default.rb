package "smartmontools" do
  action :upgrade
end

template "/etc/default/smartmontools" do
  source "smartmontools/default.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[smartmontools]"
end

node['smartmontools']['run_d'].each do |rund|
	cookbook_file "/etc/smartmontools/run.d/#{rund}" do
		source rund
		owner "root"
		group "root"
		mode 0755
	end
end

service "smartmontools" do
	supports :status => true, :reload => true, :restart => true
	action [:enable,:start]
end