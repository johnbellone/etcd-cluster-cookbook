require 'spec_helper'

describe 'etcd-cluster::default' do
  context 'with default node attributes' do
    let(:chef_run) { ChefSpec::SoloRunner.new(name: 'centos', version: '7.1').converge('etcd-cluster::default') }

    it { expect(chef_run).to create_etcd_config('') }
    it { expect(chef_run).to enable_etcd_service('etcd') }
  end
end
