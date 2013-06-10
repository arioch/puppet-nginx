require 'spec_helper'

describe 'nginx::upstream', :type => :define do
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

    it do
      expect { should create_class('nginx') }.to raise_error(Puppet::Error)
    end
  end

  #describe 'on Debian with parameter: ensure' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :upstream_nodes => '_NODES_', :ensure => '_VALUE_' } }
  #
  #  it { should_not contain_concat__fragment('nginx.conf_body_http_upstream__NAME_') }
  #end

  #describe 'on Debian with parameter: ip_hash' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :upstream_nodes => '_NODES_', :ip_hash => '_VALUE_' } }
  #
  #  it { should_not contain_concat__fragment('nginx.conf_body_http_upstream__NAME_') }
  #end

  #describe 'on Debian with parameter: upstream_backend' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :upstream_nodes => '_NODES_', :upstream_backend => '_VALUE_' } }
  #
  #  it { should_not contain_concat__fragment('nginx.conf_body_http_upstream__NAME_') }
  #end

  #describe 'on Debian with parameter: upstream_nodes' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :upstream_nodes => '_NODES_', :upstream_backend => '_VALUE_' } }
  #
  #  it { should_not contain_concat__fragment('nginx.conf_body_http_upstream__NAME_') }
  #end
end

