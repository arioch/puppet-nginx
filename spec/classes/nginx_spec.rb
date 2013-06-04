require 'spec_helper'

describe 'nginx', :type => :class do
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/etc/nginx',
      :config_dir => '/etc/nginx'
    }
  }

  describe 'on Debian without parameters' do
    let (:facts) { debian_facts }

    it { should create_class('nginx') }
    it { should include_class('nginx::install') }
    it { should include_class('nginx::config') }
    it { should include_class('nginx::service') }

    it { should contain_package('nginx').with_ensure('present') }
    it { should contain_file('/etc/nginx').with_ensure('directory') }

    it { should contain_service('nginx').with(
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true'
      )
    }
  end
end

