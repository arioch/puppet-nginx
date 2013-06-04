require 'spec_helper'

describe 'nginx', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/etc/nginx',
      :config_dir => '/etc/nginx'
    }
  }

  describe 'on Debian with parameter: accept_mutex' do
    let (:facts) { debian_facts }
    let (:params) { { :accept_mutex => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: access_log' do
    let (:facts) { debian_facts }
    let (:params) { { :access_log => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/access_log/) }
  end

  describe 'on Debian with parameter: config_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: config_dir_mode' do
    let (:facts) { debian_facts }
    let (:params) { {:config_dir => '_VALUE_', :config_dir_mode => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_file_mode' do
    let (:facts) { debian_facts }
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_mode('_VALUE_') }
  end

  describe 'on Debian with parameter: config_group' do
    let (:facts) { debian_facts }
    let (:params) { { :config_group => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_group('_VALUE_') }
  end

  describe 'on Debian with parameter: config_user' do
    let (:facts) { debian_facts }
    let (:params) { { :config_user => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_owner('_VALUE_') }
  end

  #describe 'on Debian with parameter: daemon_group' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :daemon_group => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/nginx').with_content(/_VALUE_/) }
  #end

  #describe 'on Debian with parameter: daemon_user' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :daemon_user => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/nginx').with_content(/_VALUE_/) }
  #end

  describe 'on Debian with parameter: default_type' do
    let (:facts) { debian_facts }
    let (:params) { { :default_type => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: event_model' do
    let (:facts) { debian_facts }
    let (:params) { { :event_model => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: gzip' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip => 'on' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/gzip.+on/) }
  end

  describe 'on Debian with parameter: gzip_comp_level' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_comp_level => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: gzip_disable' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_disable => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: gzip_proxied' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_proxied => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: gzip_static' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_static => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: gzip_types' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_types => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: http' do
    let (:facts) { debian_facts }
    let (:params) { { :http => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content') }
    it { should contain_concat__fragment('nginx.conf_body_http_footer') }
    it { should contain_concat__fragment('nginx.conf_body_http_header') }
    it { should contain_concat__fragment('nginx.conf_body_http_includes') }
  end

  describe 'on Debian with parameter: keepalive_timeout' do
    let (:facts) { debian_facts }
    let (:params) { { :keepalive_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: logdir' do
    let (:facts) { debian_facts }
    let (:params) { { :logdir => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: mail' do
    let (:facts) { debian_facts }
    let (:params) { { :mail => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_mail_header') }
    it { should contain_concat__fragment('nginx.conf_body_mail_footer') }
  end

  describe 'on Debian with parameter: manage_repo' do
    let (:facts) { debian_facts }
    let (:params) { { :manage_repo => '_VALUE_' } }

    it { should create_class('nginx') }
  end

  describe 'on Debian with parameter: mime_types' do
    let (:facts) { debian_facts }
    let (:params) { { :mime_types => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: multi_accept' do
    let (:facts) { debian_facts }
    let (:params) { { :multi_accept => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: pidfile' do
    let (:facts) { debian_facts }
    let (:params) { { :pidfile => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: pkg_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_ensure => '_VALUE_' } }

    it { should contain_package('nginx').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: pkg_list' do
    let (:facts) { debian_facts }
    let (:params) { { :pkg_list => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'on Debian with parameter: proxy_cache' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true } }

    it { should create_class('nginx') }
    it { should contain_concat__fragment('nginx.conf_body_http_caching') }
  end

  describe 'on Debian with parameter: proxy_cache_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_cache_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: proxy_cache_path' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_cache_path => '_VALUE_' } }

    it { should create_class('nginx') }
  end

  describe 'on Debian with parameter: proxy_connect_timeout' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_connect_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_caching').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: proxy_read_timeout' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_read_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_caching').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: proxy_send_timeout' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_send_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_caching').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: proxy_temp_path' do
    let (:facts) { debian_facts }
    let (:params) { { :proxy_cache => true, :proxy_temp_path => '_VALUE_' } }

    it { should create_class('nginx') }
  end

  describe 'on Debian with parameter: sendfile' do
    let (:facts) { debian_facts }
    let (:params) { { :sendfile => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: server_names_hash_bucket_size' do
    let (:facts) { debian_facts }
    let (:params) { { :server_names_hash_bucket_size => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: service_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :service_enable => '_VALUE_' } }

    it { should contain_service('nginx').with_enable('_VALUE_') }
  end

  describe 'on Debian with parameter: service_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :service_ensure => '_VALUE_' } }

    it { should contain_service('nginx').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: service_hasrestart' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasrestart => '_VALUE_' } }

    it { should contain_service('nginx').with_hasrestart('_VALUE_') }
  end

  describe 'on Debian with parameter: service_hasstatus' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasstatus => '_VALUE_' } }

    it { should contain_service('nginx').with_hasstatus('_VALUE_') }
  end

  describe 'on Debian with parameter: service_name' do
    let (:facts) { debian_facts }
    let (:params) { { :service_name => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'on Debian with parameter: status_allow' do
    let (:facts) { debian_facts }
    let (:params) { { :status_allow => '_VALUE_', :status_enable => true, :vhostdir_enabled => '_VHOSTDIR_' } }

    it { should contain_file('_VHOSTDIR_/status.conf').with_ensure('link') }
  end

  describe 'on Debian with parameter: status_deny' do
    let (:facts) { debian_facts }
    let (:params) { { :status_deny => '_VALUE_', :status_enable => true, :vhostdir_enabled => '_VHOSTDIR_' } }

    it { should contain_file('_VHOSTDIR_/status.conf').with_ensure('link') }
  end

  describe 'on Debian with parameter: status_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :status_enable => true, :vhostdir_enabled => '_VHOSTDIR_' } }

    it { should contain_file('_VHOSTDIR_/status.conf').with_ensure('link') }
  end

  describe 'on Debian with parameter: tcp_nodelay' do
    let (:facts) { debian_facts }
    let (:params) { { :tcp_nodelay => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: tcp_nopush' do
    let (:facts) { debian_facts }
    let (:params) { { :tcp_nopush => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: vhostdir_available' do
    let (:facts) { debian_facts }
    let (:params) { { :vhostdir_available => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: vhostdir_enabled' do
    let (:facts) { debian_facts }
    let (:params) { { :vhostdir_enabled => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: worker_connections' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_connections => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: worker_priority' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_priority => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with_content(/_VALUE_/) }
  end

  describe 'on Debian with parameter: worker_processes' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_processes => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with_content(/_VALUE_/) }
  end
end

