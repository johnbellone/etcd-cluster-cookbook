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

      attribute(:config_file, kind_of: String)
      attribute(:install_method, equal_to: %w{package source}, default: 'package')
      attribute(:install_path, kind_of: String, default: '/opt')
      attribute(:package_name, kind_of: String, default: 'etcd')
      attribute(:package_version, kind_of: String)
      attribute(:package_source, kind_of: String)
    end
  end

  module Provider
    # @since 1.0.0
    class EtcdService < Chef::Provider
      include Poise
      provides(:etcd_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          package new_resource.package_name do
            version new_resource.package_version
            source new_resource.package_source
            action :upgrade
            only_if { new_resource.install_method == 'package' }
          end

          if new_resource.install_method == 'source'
            include_recipe 'git::default', 'golang::default'

            directory ::File.join(new_resource.install_path, 'bin') do
              recursive true
            end

            %w{etcd etcdctl}.each do |project|
              git ::File.join(new_resource.install_path, project) do
                repository "https://github.com/coreos/#{project}"
                notifies :run, "bash[#{name}/build]", :immediately
              end

              bash ::File.join(new_resource.install_path, 'etcd', 'build') do
                action :nothing
              end

              link ::File.join(new_resource.install_path, 'bin') do
                to ::File.join(new_resource.install_path, project, project)
              end
            end
          end
        end
        super
      end

      private

      def service_options(resource)
      end
    end
  end
end
