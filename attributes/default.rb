#
# Cookbook: etcd-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
default['etcd']['service_user'] = 'etcd'
default['etcd']['service_group'] = 'etcd'
default['etcd']['service_name'] = 'etcd'

default['etcd']['config']['path'] = ''

default['etcd']['service']['install_method'] = 'package'
