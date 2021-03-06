# Puppet nGinX

## Build status

[![Build Status](https://travis-ci.org/arioch/puppet-nginx.png?branch=master)](https://travis-ci.org/arioch/puppet-nginx)

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
        'test01.example.com': server_name => 'test01.example.com', proxy_pass => 'http://backend';
        'test02.example.com': server_name => 'test02.example.com', proxy_pass => 'http://backend';
        'test03.example.com': server_name => 'test03.example.com', proxy_pass => 'http://backend';
        'test04.example.com': server_name => 'test04.example.com', proxy_pass => 'http://backend';
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

### Load balancing with ip hashes (sticky connections)

Sticky connections are useful for applications that rely on cookies or
being served by the same backend node for different reasons.

This is usually the case for PHP applications so it's enabled by default.

    nginx::upstream { 'backend':
      ip_hash        => true,
      upstream_nodes => [
        '10.0.1.1',
        '10.0.1.2',
        '10.0.1.3',
        '10.0.1.4'
      ];
    }

### Disable access logs

    node /frontend/ {
      class {
        'nginx':;
      }

      nginx::proxy { 'test01.example.com':
        server_name => 'test01.example.com',
        access_log  => false,
      }
    }

### Configure proxy cache

    node /frontend/ {
      class { 'nginx':
         proxy_cache           = true,
         proxy_cache_dir       = '/cache',
         proxy_cache_path      = '/cache/static levels=1:2 keys_zone=staticfilecache:60m inactive=90m max_size=500m',
         proxy_connect_timeout = '30',
         proxy_read_timeout    = '120',
         proxy_send_timeout    = '120',
         proxy_temp_path       = '/cache/tmp',
      }

      nginx::proxy { 'proxy01.example.com':
        server_name          => 'proxy01.example.com',
        proxy_pass           => 'http://backend01',
        proxy_cache_enable   => true,
        expires              => '864000',
        proxy_cache_location => '~* /.*(jpg|jpeg|png|gif|css|mp3|wav|swf|mov|ico|htm|html)$';
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

### Enable status page

    node /box/ {
      class { 'nginx':
        status_enable => true,
        status_allow  => '127.0.0.1',
        status_deny   => 'all',
      }

## Unit testing

Plain RSpec:

    $ rake spec

Using bundle:

    $ bundle exec rake spec

Test against a specific Puppet or Facter version:

    $ PUPPET_VERSION=3.2.1  bundle update && bundle exec rake spec
    $ PUPPET_VERSION=2.7.19 bundle update && bundle exec rake spec
    $ FACTER_VERSION=1.6.8  bundle update && bundle exec rake spec

