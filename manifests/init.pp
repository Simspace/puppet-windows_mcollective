# == Class: windows_mcollective
#
# Install mcollective with puppet support on Windows
#
# === Variables
#
# server
#  The ActiveMQ server. Defaults to 10.10.254.1
#
# === Example
#
#  class { windows_mcollective:
#    server => '10.10.254.1',
#  }
#
# === Authors
#
# Robert Cashman <cash@simspace.com>
#
class windows_mcollective (
  $server = '10.10.254.1',
) {

  include staging
  include windows_mcollective::facts

  $puppet_path = "${::windows_programfilesx86}\\Puppet Labs"
  $mcollective_path = "${puppet_path}\\mcollective"

  exec { 'register-mcollective':
    command => "\"${mcollective_path}\\bin\\register_service.bat\"",
    returns => [0],
    path => $::path,
    require => [ Acl["$mcollective_path\\bin\\register_service.bat"], Staging::Extract['mcollective-puppet-agent-1.9.3.zip'], Staging::Extract['mcollective-puppet-agent-1.9.3.zip'] ],
    refreshonly => true,
    subscribe => File['mcollective-server-cfg'],
  }

  staging::file { 'mcollective-2.5.2.zip':
    source => 'puppet:///modules/windows_mcollective/mcollective-2.5.2.zip',
  }

  staging::file { 'mcollective-puppet-agent-1.9.3.zip':
    source => 'puppet:///modules/windows_mcollective/mcollective-puppet-agent-1.9.3.zip',
    require => Staging::Extract['mcollective-2.5.2.zip'],
  }

  staging::file { 'mcollective-shell-agent-0.0.2.zip':
    source => 'puppet:///modules/windows_mcollective/mcollective-shell-agent-0.0.2.zip',
    require => Staging::Extract['mcollective-2.5.2.zip'],
  }

  staging::extract { 'mcollective-2.5.2.zip':
    target => "$puppet_path",
    creates => "$mcollective_path",
    require => Staging::File['mcollective-2.5.2.zip'],
  }

  staging::extract { 'mcollective-puppet-agent-1.9.3.zip':
    target => "${mcollective_path}\\plugins",
    require => Staging::File['mcollective-puppet-agent-1.9.3.zip'],
  }

  staging::extract { 'mcollective-shell-agent-0.0.2.zip':
    target => "${mcollective_path}\\plugins",
    require => Staging::File['mcollective-shell-agent-0.0.2.zip'],
  }

  acl { "$mcollective_path\\bin\\register_service.bat":
    purge => 'false',
    permissions => [ { identity => 'Administrators', rights => ['full'], child_types => 'all' },],
    require => File["$mcollective_path\\bin"],
  }

  file { "$mcollective_path\\bin":
    source => "puppet:///modules/windows_mcollective/windows",
    require => Staging::Extract['mcollective-2.5.2.zip'],
    recurse => true,
  }

  file { 'mcollective-client-cfg':
    path => "${mcollective_path}\\etc\\client.cfg",
    require => Staging::Extract['mcollective-2.5.2.zip'],
    content => template('windows_mcollective/client.cfg.erb'),
  }

  file { 'mcollective-server-cfg':
    path => "${mcollective_path}\\etc\\server.cfg",
    require => Staging::Extract['mcollective-2.5.2.zip'],
    content => template('windows_mcollective/server.cfg.erb'),
  }
}
