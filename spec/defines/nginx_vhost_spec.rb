require 'spec_helper'

describe 'nginx::vhost', :type => :define do
  let (:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:pre_condition) {
    'class { "nginx":
      http => true,
      vhostdir_available => "/tmp/available",
      vhostdir_enabled => "/tmp/enabled",
    }'
  }

  describe 'on Debian without parameters' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }

    it { should contain_nginx__vhost('_NAME_') }
  end

  describe 'on Debian with parameter: ensure' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { { :ensure => '_VALUE_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: server_name' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { { :server_name => '_NAME_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with_content(/server_name.*_NAME_/) }
  end

  describe 'on Debian with parameter: config_path' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) { { :config_path => '_VALUE_' } }

    it { should contain_file('/tmp/enabled/_NAME_.conf').with_target('_VALUE_') }
  end

  #describe 'on Debian with parameter: listen' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :listen => '80' } }

  #  it { should contain_file('/tmp/enabled/_NAME_.conf').with_content(/listen.*:80/) }
  #end
end

