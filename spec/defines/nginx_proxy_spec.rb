require 'spec_helper'

describe 'nginx::proxy', :type => :define do
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

  describe 'on Debian with parameter: access_log' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :access_log => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /access_log.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: client_body_buffer_size' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :client_body_buffer_size => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /client_body_buffer_size.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: client_max_body_size' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :client_max_body_size => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /client_max_body_size.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: enable' do
    context 'enable => true' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :proxy_pass => '_PASS_',
          :enable => true
        }
      }

      it { should contain_file('/tmp/available/_NAME_') }
      it { should contain_file('/tmp/enabled/_NAME_') }
    end

    context 'enable => false' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :proxy_pass => '_PASS_',
          :enable => false
        }
      }

      it { should \
        contain_file('/tmp/available/_NAME_').with_ensure('present')
      }

      it { should_not \
        contain_file('/tmp/enabled/_NAME_').with_ensure('present')
      }
    end
  end

  describe 'on Debian with parameter: ensure' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :ensure => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with_ensure('_NAME_') }
  end

  describe 'on Debian with parameter: error_log' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :error_log => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /error_log.*_NAME_/
      )
    }
  end

  #describe 'on Debian with parameter: listen' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :proxy_pass => '_PASS_', :listen => '_NAME_' } }
  #
  #  it { should contain_file('/tmp/available/_NAME_').with_content(/listen.*_NAME_/) }
  #end

  describe 'on Debian with parameter: log_dir' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :log_dir => '_VALUE_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /error_log.*\_VALUE_\/_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_buffers' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_buffers => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_buffers.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_cache => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_cache.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache_enable' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_cache_valid/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache_expires' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_cache_expires => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /expires.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache_location' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_cache_location => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /location.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache_pass' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_cache_pass => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_pass.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_cache_valid' do
    context 'proxy_cache_enable => true' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :proxy_pass => '_PASS_',
          :proxy_cache_enable => true,
          :proxy_cache_valid => '_NAME_'
        }
      }

      it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_cache_valid.*_NAME_/
      )
    }
    end

    context 'proxy_cache_enable => false' do
      let (:facts) { debian_facts }
      let (:title) { '_NAME_' }
      let (:params) {
        {
          :proxy_pass => '_PASS_',
          :proxy_cache_valid => '_NAME_'
        }
      }

      it { should_not contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_cache_valid.*_NAME_/
      )
    }
    end
  end

  describe 'on Debian with parameter: proxy_connect_timeout' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_connect_timeout => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_connect_timeout.*_NAME_/
      )
    }
  end

  #describe 'on Debian with parameter: proxy_ignore_headers' do
  #  let (:facts) { debian_facts }
  #  let (:title) { '_NAME_' }
  #  let (:params) { { :proxy_pass => '_PASS_', :proxy_cache_enable => true, :proxy_ignore_headers => '_NAME_' } }

  #  it { should contain_file('/tmp/available/_NAME_').with_content(/proxy_ignore_headers.*_NAME_/) }
  #end

  describe 'on Debian with parameter: proxy_pass' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_pass => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_pass.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_read_timeout' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_read_timeout => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_read_timeout.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: proxy_send_timeout' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :proxy_cache_enable => true,
        :proxy_send_timeout => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /proxy_send_timeout.*_NAME_/
      )
    }
  end

  describe 'on Debian with parameter: server_name' do
    let (:facts) { debian_facts }
    let (:title) { '_NAME_' }
    let (:params) {
      {
        :proxy_pass => '_PASS_',
        :server_name => '_NAME_'
      }
    }

    it { should contain_file('/tmp/available/_NAME_').with(
        'content' => /server_name.*_NAME_/
      )
    }
  end
end

