#
# Cookbook: etcd-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module EtcdClusterCookbook
  module Resource
    # @since 1.0.0
    class EtcdConfig < Chef::Resource
      include Poise(fused: true)
      provides(:etcd_config)
    end
  end
end
