class windows_mcollective::facts ()
{
  #The facts.yaml file resource is generated in its own dedicated class
  #By doing this, the file produced isn't polluted with unwanted in scope class variables.
 
  ##Bring in as many variables as you want from other classes here.
  #This makes them available to mcollective for use in filters.
  #eg
  #$class_variable = $class::variable
 
  #mcollective doesn't work with arrays, so use the puppet-stdlib join function
  #eg
  #$ntp_servers = join($ntp::servers, ",")

  include windows_mcollective
 
  file{"${::programfilesx86}\\Puppet Labs\\mcollective\\etc\\facts.yaml":
   content => template('windows_mcollective/facts.yaml.erb'),
   require => Exec['register-mcollective'],
  }
}
