require 'spec_helper'

describe 'nginx' do
  let(:pre_condition) { 'include concat::setup' }
  let(:title) { 'nginx' }
  let(:facts) {
    {
      :concat_basedir => '/var/lib/puppet/concat',
      :environment    => 'development',
    }
  }

  rpm_distros = [ 'RedHat', 'CentOS' ]

  rpm_distros.each do |os|
    describe "on #{os}" do
      context 'without parameters' do
        let(:facts) do
          {
            'concat_basedir'  => '/var/lib/puppet/concat',
            'operatingsystem' => os
          }
        end

        it do
          should include_class('nginx')
          should include_class('nginx::params')
          should include_class('nginx::install')
          should include_class('nginx::config')
          should include_class('nginx::service')

          should contain_file('/etc/nginx/nginx.conf')
          should contain_file('/etc/nginx').with_ensure('directory')
          should contain_file('/etc/nginx/conf.d').with_ensure('directory')
          should contain_file('/etc/nginx/nginx.conf').with_ensure('present')

          should contain_package('nginx').with_ensure('present')

          should contain_service('nginx').with(
            'ensure'    => 'running',
            'enable'    => 'true',
            'hasstatus' => 'true'
          )
        end
      end

      context 'nginx packages' do
        let(:facts) do
          {
            'concat_basedir'  => '/var/lib/puppet/concat',
            'operatingsystem' => os
          }
        end
        let(:params) {
          {
            :pkg_ensure => '_pkg_ensure_',
            :pkg_list   => '_pkg_list_'
          }
        }

        it do
          should contain_package('_pkg_list_') \
            .with_ensure('_pkg_ensure_')
        end
      end

      context 'nginx daemon' do
        let(:facts) do
          {
            'concat_basedir'  => '/var/lib/puppet/concat',
            'operatingsystem' => os
          }
        end
        let(:params) {
          {
            :service_name      => '_service_name_',
            :service_ensure    => '_service_ensure_',
            :service_enable    => '_service_enable_',
            :service_hasstatus => '_service_hasstatus_',
          }
        }

        it do
          should contain_service('_service_name_').with(
            'ensure'    => '_service_ensure_',
            'enable'    => '_service_enable_',
            'hasstatus' => '_service_hasstatus_'
          )
        end
      end

      context 'adjust configuration parameters' do
        let(:facts) do
          {
            'concat_basedir'  => '/var/lib/puppet/concat',
            'operatingsystem' => os
          }
        end
        let(:params) {
          {
            :logdir             => '_logdir_',
            :mime_types         => '_mime_types_',
            :worker_processes   => '001',
            :worker_connections => '002',
            :keepalive_timeout  => '003',
            :sendfile           => '_sendfile_',
            :tcp_nodelay        => '_tcp_nodelay_',
            :gzip               => '_gzip_',
            :tcp_nopush         => '_tcp_nopush_',
            :daemon_user        => '_daemon_user_',
            :config_dir         => '_config_dir_',
            :vhostdir_available => '_vhostdir_available',
            :vhostdir_enabled   => '_vhostdir_enabled',
            :pidfile            => '_pidfile_',
            :config_user        => '_config_user_',
            :config_group       => '_config_group_'
          }
        }

        it do
          should contain_file('_config_dir_/nginx.conf') \
            .with_owner('_config_user_')

          should contain_file('_config_dir_/nginx.conf') \
            .with_group('_config_group_')
        end
      end
    end
  end
end

