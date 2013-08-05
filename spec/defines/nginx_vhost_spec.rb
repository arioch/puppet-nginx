require 'spec_helper'

describe 'nginx::vhost', :type => :define do
  let (:facts) { debian_facts }
  let (:pre_condition) {
    '$concat_basedir = "/tmp"
    class { "nginx":
      http => true,
      vhostdir_available => "/tmp/available",
      vhostdir_enabled => "/tmp/enabled",
    }'
  }

  describe 'without parameters' do
    let (:title) { '_NAME_' }

    it { should contain_nginx__vhost('_NAME_') }
  end

  describe 'with parameter: ensure' do
    let (:title) { '_NAME_' }
    let (:params) { { :ensure => '_VALUE_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with(
        'ensure' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: server_name' do
    let (:title) { '_NAME_' }
    let (:params) { { :server_name => '_NAME_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with(
        'content' => /server_name.*_NAME_/
      )
    }
  end

  describe 'with parameter: config_path' do
    let (:title) { '_NAME_' }
    let (:params) { { :config_path => '_VALUE_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with(
        'target' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: listen' do
    let (:title) { '_NAME_' }
    let (:params) { { :listen => [ '_VALUE_' ] } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with(
        'content' => /listen _VALUE_;/
      )
    }
  end
end

