require 'spec_helper'

describe 'nginx', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) { { :config_dir => '/etc/nginx' } }

  describe 'on Debian with parameter: accept_mutex' do
    let (:facts) { debian_facts }
    let (:params) { { :accept_mutex => true } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /accept_mutex.*on;/
      )
    }
  end

  describe 'on Debian with parameter: access_log' do
    context 'access_log => true' do
      let (:facts) { debian_facts }
      let (:params) { { :access_log => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_content').with(
          'content' => /access_log.*;/
        )
      }
    end

    context 'access_log => false' do
      let (:facts) { debian_facts }
      let (:params) { { :access_log => false } }

      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_content').with(
          'content' => /access_log.*;/
        )
      }
    end
  end

  describe 'on Debian with parameter: config_dir' do
    let (:facts) { debian_facts }
    let (:params) { { :config_dir => '_VALUE_' } }

    it { should contain_file('_VALUE_').with_ensure('directory') }
  end

  describe 'on Debian with parameter: config_dir_mode' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :config_dir => '_VALUE_',
        :config_dir_mode => '_VALUE_'
      }
    }

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

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: event_model' do
    let (:facts) { debian_facts }
    let (:params) { { :event_model => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: gzip' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /gzip.+on;/
      )
    }
  end

  describe 'on Debian with parameter: gzip_comp_level' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_comp_level => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: gzip_disable' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_disable => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /"_VALUE_";/
      )
    }
  end

  describe 'on Debian with parameter: gzip_proxied' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_proxied => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: gzip_static' do
    let (:facts) { debian_facts }

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

  describe 'on Debian with parameter: gzip_types' do
    let (:facts) { debian_facts }
    let (:params) { { :gzip_types => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: http' do
    context 'http => true' do
      let (:facts) { debian_facts }
      let (:params) { { :http => true } }

      it { should contain_concat__fragment('nginx.conf_body_http_content') }
      it { should contain_concat__fragment('nginx.conf_body_http_footer') }
      it { should contain_concat__fragment('nginx.conf_body_http_header') }
      it { should contain_concat__fragment('nginx.conf_body_http_includes') }
    end

    context 'http => false' do
      let (:facts) { debian_facts }
      let (:params) { { :http => false } }

      it { should_not contain_concat__fragment('nginx.conf_body_http_content') }
      it { should_not contain_concat__fragment('nginx.conf_body_http_footer') }
      it { should_not contain_concat__fragment('nginx.conf_body_http_header') }
      it { should_not \
        contain_concat__fragment('nginx.conf_body_http_includes')
      }
    end
  end

  describe 'on Debian with parameter: keepalive_timeout' do
    let (:facts) { debian_facts }
    let (:params) { { :keepalive_timeout => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /keepalive_timeout.*_VALUE_;/
      )
    }
  end

  describe 'on Debian with parameter: logdir' do
    let (:facts) { debian_facts }
    let (:params) { { :logdir => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /\/tmp.*;/
      )
    }
  end

  describe 'on Debian with parameter: mail' do
    let (:facts) { debian_facts }

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

  #describe 'on Debian with parameter: manage_repo' do
  #  let (:facts) { debian_facts }
  #  let (:params) { { :manage_repo => '_VALUE_' } }
  #
  #  it { should create_class('nginx') }
  #end

  describe 'on Debian with parameter: mime_types' do
    let (:facts) { debian_facts }
    let (:params) { { :mime_types => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /\/tmp;/
      )
    }
  end

  describe 'on Debian with parameter: multi_accept' do
    let (:facts) { debian_facts }
    let (:params) { { :multi_accept => true } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /multi_accept.*on;/
      )
    }
  end

  describe 'on Debian with parameter: pidfile' do
    let (:facts) { debian_facts }
    let (:params) { { :pidfile => '/tmp' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /\/tmp/
      )
    }
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

  describe 'on Debian with parameter: proxy_cache_dir' do
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

  describe 'on Debian with parameter: proxy_cache_path' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :proxy_cache => true,
        :proxy_cache_path => '_VALUE_'
      }
    }

    it { should create_class('nginx') }
  end

  describe 'on Debian with parameter: proxy_connect_timeout' do
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

  describe 'on Debian with parameter: proxy_read_timeout' do
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

  describe 'on Debian with parameter: proxy_send_timeout' do
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

  describe 'on Debian with parameter: proxy_temp_path' do
    let (:facts) { debian_facts }
    let (:params) {
      {
        :proxy_cache => true,
        :proxy_temp_path => '/tmp'
      }
    }

    it { should create_class('nginx') }
  end

  describe 'on Debian with parameter: sendfile' do
    let (:facts) { debian_facts }
    let (:params) { { :sendfile => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /sendfile.*on;/
      )
    }
  end

  describe 'on Debian with parameter: server_names_hash_bucket_size' do
    let (:facts) { debian_facts }
    let (:params) { { :server_names_hash_bucket_size => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: service_enable' do
    let (:facts) { debian_facts }
    let (:params) { { :service_enable => true } }

    it { should contain_service('nginx').with_enable(true) }
  end

  describe 'on Debian with parameter: service_ensure' do
    let (:facts) { debian_facts }
    let (:params) { { :service_ensure => '_VALUE_' } }

    it { should contain_service('nginx').with_ensure('_VALUE_') }
  end

  describe 'on Debian with parameter: service_hasrestart' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasrestart => true } }

    it { should contain_service('nginx').with_hasrestart(true) }
  end

  describe 'on Debian with parameter: service_hasstatus' do
    let (:facts) { debian_facts }
    let (:params) { { :service_hasstatus => true } }

    it { should contain_service('nginx').with_hasstatus(true) }
  end

  describe 'on Debian with parameter: service_name' do
    let (:facts) { debian_facts }
    let (:params) { { :service_name => '_VALUE_' } }

    it { should contain_service('_VALUE_') }
  end

  describe 'on Debian with parameter: status_allow' do
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

  describe 'on Debian with parameter: status_deny' do
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

  describe 'on Debian with parameter: status_enable' do
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

  describe 'on Debian with parameter: tcp_nodelay' do
    let (:facts) { debian_facts }
    let (:params) { { :tcp_nodelay => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /tcp_nodelay.*on;/
      )
    }
  end

  describe 'on Debian with parameter: tcp_nopush' do
    let (:facts) { debian_facts }
    let (:params) { { :tcp_nopush => true } }

    it { should contain_concat__fragment('nginx.conf_body_http_content').with(
        'content' => /tcp_nopush.*on;/
      )
    }
  end

  describe 'on Debian with parameter: vhostdir_available' do
    let (:facts) { debian_facts }
    let (:params) { { :vhostdir_available => '/tmp' } }

    it { should contain_file('/tmp').with_ensure('directory') }
  end

  describe 'on Debian with parameter: vhostdir_enabled' do
    let (:facts) { debian_facts }
    let (:params) { { :vhostdir_enabled => '/tmp' } }

    it { should contain_file('/tmp').with_ensure('directory') }
  end

  describe 'on Debian with parameter: worker_connections' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_connections => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_body_events_content').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: worker_priority' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_priority => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: worker_processes' do
    let (:facts) { debian_facts }
    let (:params) { { :worker_processes => '_VALUE_' } }

    it { should contain_concat__fragment('nginx.conf_header').with(
        'content' => /_VALUE_/
      )
    }
  end
end

