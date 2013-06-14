require 'spec_helper'

describe 'nginx::mail', :type => :define do
  let (:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:pre_condition) {
    'class { "nginx":
      mail => true,
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

  describe 'on Debian with parameter: server_name' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :server_name => '_NAME_',
        :protocol => 'smtp'
      }
    }

    it { should contain_concat__fragment('nginx.conf_body_mail__NAME_') }
  end

  describe 'on Debian with parameter: ensure' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :server_name => '_NAME_',
        :protocol => 'smtp',
        :ensure => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'ensure' => '_VALUE_'
      )
    }
  end

  describe 'on Debian with parameter: listen_address' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :server_name => '_NAME_',
        :protocol => 'smtp',
        :listen_address => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: listen_port' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :server_name => '_NAME_',
        :protocol => 'smtp',
        :listen_port => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: protocol' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }

    context 'imap' do
      let (:params) {
        {
          :server_name => '_NAME_',
          :protocol => 'imap',
          :protocol => 'imap'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:143/
      )
    }
    end

    context 'imaps' do
      let (:params) {
        {
          :server_name => '_NAME_',
          :protocol => 'imaps',
          :protocol => 'imaps'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:993/
      )
    }
    end

    context 'pop3' do
      let (:params) {
        {
          :server_name => '_NAME_',
          :protocol => 'pop3',
          :protocol => 'pop3'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:110/
      )
    }
    end

    context 'pop3s' do
      let (:params) {
        {
          :server_name => '_NAME_',
          :protocol => 'pop3s',
          :protocol => 'pop3s'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:995/
      )
    }
    end

    context 'smtp' do
      let (:params) {
        {
          :server_name => '_NAME_',
          :protocol => 'smtp',
          :protocol => 'smtp'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /listen.*:25/
      )
    }
    end
  end

  describe 'on Debian with parameter: proxy' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :server_name => '_NAME_',
        :protocol => 'smtp',
        :proxy => '_VALUE_'
      }
    }

    it { should contain_concat__fragment('nginx.conf_body_mail__NAME_').with(
        'content' => /proxy.*_VALUE_/
      )
    }
  end
end

