# Puppet nGinX

## Requirements

* [concat module](https://github.com/ripienaar/puppet-concat)
* Debian/Ubuntu: Puppetlabs [apt module](https://github.com/puppetlabs/puppetlabs-apt)

## Tested on...

* Debian 6 (Squeeze)

## Example usage

### HTTP reverse proxy

    node /frontend/ {
      class {
        'nginx':;
      }
        
      Nginx::Proxy {
        ensure => present,
        enable => true,
      }
    
      nginx::proxy {
        'test01.example.com': server_name => 'test01.example.com', proxy_pass => 'http://10.0.0.1';
        'test02.example.com': server_name => 'test02.example.com', proxy_pass => 'http://10.0.0.2';
      }
    
    }

### HTTP reverse proxy, with load balancing

    node /frontend/ {
      class {
        'nginx':;
      }
    
      Nginx::Proxy {
        ensure     => present,
        enable     => true,
        proxy_pass => 'http://backend',
      }
    
      nginx::proxy {
        'test01.example.com': server_name => 'test01.example.com';
        'test02.example.com': server_name => 'test02.example.com';
        'test03.example.com': server_name => 'test03.example.com';
        'test04.example.com': server_name => 'test04.example.com';
      }
    
      nginx::upstream { 'backend':
        ip_hash        => true,
        upstream_nodes => [
          '10.0.1.1',
          '10.0.1.2',
          '10.0.1.3',
          '10.0.1.4'
        ];
      }
    }
    
### Mail proxy

    node /frontend/ {
      class {
        'nginx': mail => true;
      }
    
      Nginx::Mail {
        ensure         => present,
        server_name    => $::fqdn,
        listen_address => $::ipaddress,
        proxy          => 'on'
      }
    
      nginx::mail {
        'imap':     listen_port => '143', protocol => 'imap';
        'imaps':    listen_port => '993', protocol => 'imap';
        'pop3':     listen_port => '110', protocol => 'pop3';
        'pop3s':    listen_port => '995', protocol => 'pop3';
        'smtp':     listen_port => '25',  protocol => 'smtp';
        'smtp-465': listen_port => '465', protocol => 'smtp';
        'smtp-587': listen_port => '587', protocol => 'smtp';
      }
    }

