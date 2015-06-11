# PRIVATE CLASS - do not use directly
#
# The puppetdb default configuration settings.
class puppetdb::params {
  $listen_address            = 'localhost'
  $listen_port               = '8080'
  $open_listen_port          = false
  $ssl_listen_address        = '0.0.0.0'
  $ssl_listen_port           = '8081'
  $ssl_protocols             = undef
  $disable_ssl               = false
  $open_ssl_listen_port      = undef
  $postgres_listen_addresses = 'localhost'

  $database                  = 'postgres'
  $manage_dbserver           = true

  # The remaining database settings are not used for an embedded database
  $database_host          = 'localhost'
  $database_port          = '5432'
  $database_name          = 'puppetdb'
  $database_username      = 'puppetdb'
  $database_password      = 'puppetdb'
  $database_ssl           = false
  $database_validate      = true
  $database_embedded_path = '/opt/puppetlabs/server/data/puppetdb/db/db'
  $postgres_version       = '9.4'
  $manage_pg_repo         = false

  # These settings manage the various auto-deactivation and auto-purge settings
  $node_ttl               = '0s'
  $node_purge_ttl         = '0s'
  $report_ttl             = '14d'

  $puppetdb_version       = 'present'

  $gc_interval            = '60'

  $log_slow_statements    = '10'
  $conn_max_age           = '60'
  $conn_keep_alive        = '45'
  $conn_lifetime          = '0'

  $max_threads            = undef

  # These settings are for the read database
  $read_database            = 'postgres'
  $read_database_host       = undef
  $read_database_port       = '5432'
  $read_database_name       = 'puppetdb'
  $read_database_username   = 'puppetdb'
  $read_database_password   = 'puppetdb'
  $read_database_ssl        = false
  $read_database_validate   = true
  $read_log_slow_statements = '10'
  $read_conn_max_age        = '60'
  $read_conn_keep_alive     = '45'
  $read_conn_lifetime       = '0'

  $manage_firewall = true
  $java_args       = {}
  $test_url        = '/pdb/meta/v1/version'

  $puppetdb_package     = 'puppetdb'
  $puppetdb_service     = 'puppetdb'
  $puppetdb_user        = 'puppetdb'
  $puppetdb_group       = 'puppetdb'
  $masterless           = false
  $puppet_service_name  = 'puppetserver'

  case $::osfamily {
    'RedHat', 'Suse', 'Archlinux': {
      $confdir                = '/etc/puppetlabs/puppetdb/conf.d'
      $puppetdb_initconf      = '/etc/sysconfig/puppetdb'
      if $settings::confdir != undef {
        $puppet_confdir       = $settings::confdir
      } else {
        $puppet_confdir       = '/etc/puppetlabs/puppet'
      }
      $ssl_dir                = '/etc/puppetlabs/puppetdb/ssl'
    }
    'Debian': {
      $confdir                = '/etc/puppetlabs/puppetdb/conf.d'
      $puppetdb_initconf      = '/etc/default/puppetdb'
      if $settings::confdir != undef {
        $puppet_confdir       = $settings::confdir
      } else {
        $puppet_confdir       = '/etc/puppetlabs/puppet'
      }
      $ssl_dir                = '/etc/puppetlabs/puppetdb/ssl'
    }
    'OpenBSD': {
      $confdir                = '/etc/puppetlabs/puppetdb/conf.d'
      $puppetdb_initconf      = undef
      if $settings::confdir != undef {
        $puppet_confdir       = $settings::confdir
      } else {
        $puppet_confdir       = '/etc/puppetlabs/puppet'
      }
      $ssl_dir                = '/etc/puppetlabs/puppetdb/ssl'
    }
    'FreeBSD': {
      $confdir                = '/usr/local/etc/puppetlabs/puppetdb/conf.d'
      $puppetdb_initconf      = undef
      if $settings::confdir != undef {
        $puppet_confdir       = $settings::confdir
      } else {
        $puppet_confdir       = '/usr/local/etc/puppetlabs/puppet'
      }
      $ssl_dir                = '/usr/local/etc/puppetlabs/puppetdb/ssl'
    }
    default: {
      fail("${module_name} does not support your osfamily ${::osfamily}")
    }
  }

  $puppet_conf              = "${puppet_confdir}/puppet.conf"
  $puppetdb_startup_timeout = 120
  $puppetdb_service_status  = 'running'

  $command_threads          = undef
  $store_usage              = undef
  $temp_usage               = undef

  $ssl_set_cert_paths        = false
  $ssl_cert_path             = "${ssl_dir}/public.pem"
  $ssl_key_path              = "${ssl_dir}/private.pem"
  $ssl_ca_cert_path          = "${ssl_dir}/ca.pem"
  $ssl_deploy_certs          = false
  $ssl_key                   = undef
  $ssl_cert                  = undef
  $ssl_ca_cert               = undef

}
