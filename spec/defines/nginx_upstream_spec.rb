require 'spec_helper'

describe 'nginx::upstream', :type => :define do
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

    it do
      expect { should create_class('nginx') }.to raise_error(Puppet::Error)
    end
  end

  describe 'with parameter: ensure' do
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :upstream_nodes => [ '_NODES_' ],
        :ensure => '_VALUE_'
      }
    }

    it { should \
      contain_concat__fragment('nginx.conf_body_http_upstream__NAME_').with(
        'content' => /upstream _NAME_/
      )
    }
  end

  describe 'with parameter: ip_hash' do
    let (:title) { '_NAME_' }

    context 'ip_hash => true' do
      let (:params) {
        {
          :upstream_nodes => [ '_NODES_' ],
          :ip_hash => true
        }
      }

      it { should \
        contain_concat__fragment('nginx.conf_body_http_upstream__NAME_').with(
          'content' => / ip_hash;/
        )
      }
    end

    context 'ip_hash => false' do
      let (:params) {
        {
          :upstream_nodes => [ '_NODES_' ],
          :ip_hash => false
        }
      }

      it { should \
        contain_concat__fragment('nginx.conf_body_http_upstream__NAME_').with(
          'content' => /# ip_hash;/
        )
      }
    end
  end

  describe 'with parameter: upstream_backend' do
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :upstream_nodes => [ '_NODES_' ],
        :upstream_backend => '_VALUE_'
      }
    }

    it { should \
      contain_concat__fragment('nginx.conf_body_http_upstream__NAME_').with(
        'content' => /upstream _VALUE_/
      )
    }
  end

  describe 'with parameter: upstream_nodes' do
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :upstream_nodes => [ '_NODES_' ],
        :upstream_backend => '_VALUE_'
      }
    }

    it { should \
      contain_concat__fragment('nginx.conf_body_http_upstream__NAME_').with(
        'content' => /server _NODES_/
      )
    }
  end
end

