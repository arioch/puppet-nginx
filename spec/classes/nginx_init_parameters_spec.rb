require 'spec_helper'

describe 'nginx', :type => :class do
  let (:facts) { debian_facts }
  let (:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) { { :config_dir => '/etc/nginx' } }

  describe 'with parameter: accept_mutex' do
    let (:params) { { :accept_mutex => true } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /accept_mutex.*on;/
      )
    }
  end

  describe 'with parameter: access_log' do
    context 'access_log => true' do
      let (:params) { { :access_log => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_content').with(
          'content' => /access_log.*;/
        )
      }
    end

    context 'access_log => false' do
      let (:params) { { :access_log => false } }

      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_content').with(
          'content' => /access_log.*;/
        )
      }
    end
  end

  describe 'with parameter: config_dir' do
    let (:params) { { :config_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'with parameter: config_dir_mode' do
    let (:params) {
      {
        :config_dir => '_VALUE_',
        :config_dir_mode => '_VALUE_'
      }
    }

    it { should contain_file('_VALUE_').with_mode('_VALUE_') }
  end

  describe 'with parameter: config_file_mode' do
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_mode('_VALUE_') }
  end

  describe 'with parameter: config_group' do
    let (:params) { { :config_group => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_group('_VALUE_') }
  end

  describe 'with parameter: config_user' do
    let (:params) { { :config_user => '_VALUE_' } }

    it { should contain_file('/etc/nginx/nginx.conf').with_owner('_VALUE_') }
  end

  #describe 'with parameter: daemon_group' do
  #  let (:params) { { :daemon_group => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/nginx').with_content(/_VALUE_/) }
  #end

  #describe 'with parameter: daemon_user' do
  #  let (:params) { { :daemon_user => '_VALUE_' } }
  #
  #  it { should contain_file('/etc/default/nginx').with_content(/_VALUE_/) }
  #end

  describe 'with parameter: default_type' do
    let (:params) { { :default_type => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'with parameter: event_model' do
    let (:params) { { :event_model => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'with parameter: gzip' do
    let (:params) { { :gzip => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /gzip.+on;/
      )
    }
  end

  describe 'with parameter: gzip_comp_level' do
    let (:params) { { :gzip_comp_level => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'with parameter: gzip_disable' do
    let (:params) { { :gzip_disable => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /"_VALUE_";/
      )
    }
  end

  describe 'with parameter: gzip_proxied' do
    let (:params) { { :gzip_proxied => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'with parameter: gzip_static' do

    context 'gzip_static => true' do
      let (:params) { { :gzip_static => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /gzip_static.*on;/
      )
    }
    end

    context 'gzip_static => false' do
      let (:params) { { :gzip_static => false } }

      it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /gzip_static.*off;/
      )
    }
    end
  end

  describe 'with parameter: gzip_types' do
    let (:params) { { :gzip_types => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'with parameter: http' do
    context 'http => true' do
      let (:params) { { :http => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_content') }
      it { should contain_concat__fragment('nginx.conf_body_http_footer') }
      it { should contain_concat__fragment('nginx.conf_body_http_header') }
      it { should contain_concat__fragment('nginx.conf_body_http_includes') }
    end

    context 'http => false' do
      let (:params) { { :http => false } }

      it { should_not contain_concat__fragment('nginx.conf_body_http_content') }
      it { should_not contain_concat__fragment('nginx.conf_body_http_footer') }
      it { should_not contain_concat__fragment('nginx.conf_body_http_header') }
      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_includes')
      }
    end
  end

  describe 'with parameter: keepalive_timeout' do
    let (:params) { { :keepalive_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /keepalive_timeout.*_VALUE_;/
      )
    }
  end

  describe 'with parameter: logdir' do
    let (:params) { { :logdir => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /\/tmp.*;/
      )
    }
  end

  describe 'with parameter: mail' do
    context 'mail => enable' do
      let (:params) { { :mail => true } }

      it { should contain_concat__fragment('nginx.conf_body_mail_header') }
      it { should contain_concat__fragment('nginx.conf_body_mail_footer') }
    end

    context 'mail => disable' do
      it { should_not contain_concat__fragment('nginx.conf_body_mail_header') }
      it { should_not contain_concat__fragment('nginx.conf_body_mail_footer') }
    end
  end

  #describe 'with parameter: manage_repo' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :manage_repo => '_VALUE_' } }
  #
  #  it { should create_class('nginx') }
  #end

  describe 'with parameter: mime_types' do
    let (:params) { { :mime_types => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /\/tmp;/
      )
    }
  end

  describe 'with parameter: multi_accept' do
    let (:params) { { :multi_accept => true } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /multi_accept.*on;/
      )
    }
  end

  describe 'with parameter: pidfile' do
    let (:params) { { :pidfile => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /\/tmp/
      )
    }
  end

  describe 'with parameter: pkg_ensure' do
    let (:params) { { :pkg_ensure => '_VALUE_' } }

    it { should contain_package('nginx').with_ensure('_VALUE_') }
  end

  describe 'with parameter: pkg_list' do
    let (:params) { { :pkg_list => '_VALUE_' } }

    it { should contain_package('_VALUE_') }
  end

  describe 'with parameter: proxy_cache' do
    context 'proxy_cache => true' do
      let (:facts) { debian_facts }
      let (:params) { { :proxy_cache => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_caching') }
    end

    context 'proxy_cache => false' do
      let (:facts) { debian_facts }
      let (:params) { { :proxy_cache => false } }

      it { should_not contain_concat__fragment('nginx.conf_body_http_caching') }
    end
  end

  describe 'with parameter: proxy_cache_dir' do
    context 'proxy_cache_dir => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => true,
          :proxy_cache_dir => '_VALUE_'
        }
      }

      it { should contain_file('_VALUE_').with_ensure('directory') }
    end

    context 'proxy_cache_dir => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => false,
          :proxy_cache_dir => '_VALUE_'
        }
      }

      it { should_not contain_file('_VALUE_').with_ensure('directory') }
    end
  end

  describe 'with parameter: proxy_cache_path' do
    let (:params) {
      {
        :proxy_cache => true,
        :proxy_cache_path => '_VALUE_'
      }
    }

    it { should create_class('nginx') }
  end

  describe 'with parameter: proxy_connect_timeout' do
    context 'proxy_connect_timeout => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => true,
          :proxy_connect_timeout => '_VALUE_'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_http_caching').with(
        'content' => /_VALUE_/
      )
    }
    end

    context 'proxy_connect_timeout => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => false,
          :proxy_connect_timeout => '_VALUE_'
        }
      }

      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_caching').with(
          'content' => /_VALUE_/
      )
    }
    end
  end

  describe 'with parameter: proxy_read_timeout' do
    context 'proxy_read_timeout => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => true,
          :proxy_read_timeout => '_VALUE_'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_http_caching').with(
        'content' => /_VALUE_/
      )
    }
    end

    context 'proxy_read_timeout => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => false,
          :proxy_read_timeout => '_VALUE_'
        }
      }

      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_caching').with(
        'content' => /_VALUE_/
      )
    }
    end
  end

  describe 'with parameter: proxy_send_timeout' do
    context 'proxy_send_timeout => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => true,
          :proxy_send_timeout => '_VALUE_'
        }
      }

      it { should contain_concat__fragment('nginx.conf_body_http_caching').with(
        'content' => /_VALUE_/
      )
    }
    end

    context 'proxy_send_timeout => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :proxy_cache => false,
          :proxy_send_timeout => '_VALUE_'
        }
      }

      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_caching').with(
        'content' => /_VALUE_/
      )
    }
    end
  end

  describe 'with parameter: proxy_temp_path' do
    let (:params) {
      {
        :proxy_cache => true,
        :proxy_temp_path => '/tmp'
      }
    }

    it { should create_class('nginx') }
  end

  describe 'with parameter: sendfile' do
    let (:params) { { :sendfile => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /sendfile.*on;/
      )
    }
  end

  describe 'with parameter: server_names_hash_bucket_size' do
    let (:params) { { :server_names_hash_bucket_size => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: service_enable' do
    let (:params) { { :service_enable => true } }

    it { should contain_service('nginx').with_enable(true) }
  end

  describe 'with parameter: service_ensure' do
    let (:params) { { :service_ensure => '_VALUE_' } }

    it { should contain_service('nginx').with_ensure('_VALUE_') }
  end

  describe 'with parameter: service_hasrestart' do
    let (:params) { { :service_hasrestart => true } }

    it { should contain_service('nginx').with_hasrestart(true) }
  end

  describe 'with parameter: service_hasstatus' do
    let (:params) { { :service_hasstatus => true } }

    it { should contain_service('nginx').with_hasstatus(true) }
  end

  describe 'with parameter: service_name' do
    let (:params) { { :service_name => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'with parameter: status_allow' do
    context 'status_enable => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_allow => '127.0.0.1',
          :status_enable => true,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should contain_file('/tmp/status.conf').with_ensure('link') }
    end

    context 'status_enable => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_allow => '127.0.0.1',
          :status_enable => false,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should_not contain_file('/tmp/status.conf').with_ensure('link') }
    end
  end

  describe 'with parameter: status_deny' do
    context 'status_enable => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_deny => '_VALUE_',
          :status_enable => true,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should contain_file('/tmp/status.conf').with_ensure('link') }
    end

    context 'status_enable => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_deny => '_VALUE_',
          :status_enable => false,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should_not contain_file('/tmp/status.conf').with_ensure('link') }
    end
  end

  describe 'with parameter: status_enable' do
    context 'status_enable => true' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_enable => '_VALUE_',
          :status_enable => true,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should contain_file('/tmp/status.conf').with_ensure('link') }
    end

    context 'status_enable => false' do
      let (:facts) { debian_facts }
      let (:params) {
        {
          :status_enable => '_VALUE_',
          :status_enable => false,
          :vhostdir_enabled => '/tmp'
        }
      }

      it { should_not contain_file('/tmp/status.conf').with_ensure('link') }
    end
  end

  describe 'with parameter: tcp_nodelay' do
    let (:params) { { :tcp_nodelay => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /tcp_nodelay.*on;/
      )
    }
  end

  describe 'with parameter: tcp_nopush' do
    let (:params) { { :tcp_nopush => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /tcp_nopush.*on;/
      )
    }
  end

  describe 'with parameter: vhostdir_available' do
    let (:params) { { :vhostdir_available => '/tmp' } }

    it { should contain_file('/tmp').with_ensure('directory') }
  end

  describe 'with parameter: vhostdir_enabled' do
    let (:params) { { :vhostdir_enabled => '/tmp' } }

    it { should contain_file('/tmp').with_ensure('directory') }
  end

  describe 'with parameter: worker_connections' do
    let (:params) { { :worker_connections => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: worker_priority' do
    let (:params) { { :worker_priority => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: worker_processes' do
    let (:params) { { :worker_processes => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /_VALUE_/
      )
    }
  end
end

