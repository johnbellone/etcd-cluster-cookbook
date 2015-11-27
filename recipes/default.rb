#
# Cookbook: etcd-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
poise_service_user node['etcd']['service_user'] do
  group node['etcd']['service_group']
end

etcd_config node['etcd']['service_name'] do |r|
  node['etcd']['config'].each_pair { |k,v| r.send(k, v) }
  notifies :restart, "etc_service[#{name}]", :delayed
end

etcd_service node['etcd']['service_name'] do |r|
  config_file node['etcd']['config']['path']
  node['etcd']['service'].each_pair { |k,v| r.send(k, v) }
end
