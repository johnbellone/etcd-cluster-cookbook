#
# Cookbook: etcd-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module EtcdClusterCookbook
  module Resource
    # @since 1.0.0
    class EtcdService < Chef::Resource
      include Poise
      provides(:etcd_service)
      include PoiseService::ServiceMixin
    end
  end

  module Provider
    # @since 1.0.0
    class EtcdService < Chef::Provider
      include Poise
      provides(:etcd_service)
      include PoiseService::ServiceMixin
    end
  end
end
