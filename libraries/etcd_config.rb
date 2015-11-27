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

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:mode, kind_of: String, default: '0640')
      attribute(:owner, kind_of: String, default: 'etcd')
      attribute(:group, kind_of: String, default: 'etcd')

      attribute(:member_name, kind_of: String, default: lazy { node['fqdn'] })
      attribute(:cors, kind_of: [Array, String])
      attribute(:data_directory, kind_of: String, default: lazy {  })
      attribute(:wal_directory, kind_of: String, default: lazy {  })
      attribute(:snapshot_count, kind_of: Integer, default: 10_000)
      attribute(:heartbeat_interval, kind_of: Integer, default: 100)
      attribute(:election_timeout, kind_of: Integer, default: 1_000)
      attribute(:listen_peer_urls, kind_of: [Array, String], default: 'localhost:2380,localhost:7001')
      attribute(:listen_client_urls, kind_of: [Array, String], default: 'localhost:2379,localhost:4001')
      attribute(:max_snapshots, kind_of: Integer, default: 5)
      attribute(:max_wals, kind_of: Integer, default: 5)
      attribute(:initial_advertise_peer_urls, kind_of: [Array, String])
      attribute(:initial_cluster, kind_of: [Array, String])
      attribute(:initial_cluster_state, kind_of: String)
      attribute(:initial_cluster_token, kind_of: String)
      attribute(:advertise_client_urls, kind_of: [Array, String])
      attribute(:discovery, kind_of: String)
      attribute(:discovery_srv, kind_of: String)
      attribute(:discovery_fallback, equal_to: %w{exit proxy}, default: 'proxy')
      attribute(:discovery_proxy, kind_of: String)
      attribute(:strict_reconfig_check, equal_to: [true, false], default: false)
      attribute(:proxy, equal_to: %w{off on}, default: 'off')
      attribute(:proxy_failure_wait, kind_of: Integer, default: 5_000)
      attribute(:proxy_refresh_interval, kind_of: Integer, default: 30_000)
      attribute(:proxy_dial_timeout, kind_of: Integer, default: 1_000)
      attribute(:proxy_write_timeout, kind_of: Integer, default: 5_000)
      attribute(:proxy_read_timeout, kind_of: Integer, default: 0)
      attribute(:cert_file, kind_of: String)
      attribute(:key_file, kind_of: String)
      attribute(:trusted_ca_file, kind_of: String)
      attribute(:peer_cert_file, kind_of: String)
      attribute(:peer_key_file, kind_of: String)
      attribute(:peer_trusted_ca_file, kind_of: String)
      attribute(:peer_client_cert_auth, equal_to: [true, false], default: false)
      attribute(:client_cert_auth, equal_to: [true, false], default: false)
      attribute(:debug, equal_to: [true, false], default: false)

      def to_h
        {}.tap do |h|
          h << { 'ETCD_NAME' => member_name } if member_name
          h << { 'ETCD_DATA_DIR' => data_directory } if data_directory
          h << { 'ETCD_WAL_DIR' => wal_directory } if data_directory
        end
      end

      action(:create) do
        notifying_block do
          rc_file new_resource.path do
            type 'bash'
            mode new_resource.mode
            owner new_resource.owner
            group new_resource.group
            options new_resource.to_hash
          end
        end
      end
    end
  end
end
