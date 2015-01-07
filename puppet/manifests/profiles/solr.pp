# == Class: profile::solr
#
# Solr profile
#
class profile::solr {

  # Work-around
  # @todo Override catalina_home for the ::tomcat Class
  $catalina_home = '/var/lib/tomcat'

  $install_destination = '/opt/solr/solr-4.2.0/dist/solr-4.2.0.war' # @todo Resolve this issue
  $deployment_path = '/var/lib/tomcat/webapps'

  $war_path = '/opt/solr/solr-4.2.0/dist/solr-4.2.0.war' # @todo Resolve this issue
  $install_dir_path = '/opt/solr-4.2.0/solr'

  # Islandora/Fedora Generic Search is documented as supporting Solr 4.2.0
  # For Solr 4.2.0
#  class { "::solr":

#    install_source => 'http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz',
#    require => Tomcat::Instance['default']
#  }

  exec { 'download_solr':

    command => '/usr/bin/wget http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz -O /tmp/solr.tgz',
    unless => '/usr/bin/stat /tmp/solr.tgz'
  }

  exec { 'decompress_solr':

    command => "/usr/bin/tar -xf http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz -C /opt",
    unless => '/usr/bin/stat /opt/solr-4.2.0',
    require => Exec['download_solr']
  }

  exec { 'install_solr':

    command => "/bin/cp -r /opt/solr-4.2.0/example/solr /usr/share/solr",
    unless => '/usr/bin/stat /usr/share/solr',
    require => Exec['decompress_solr']
  }

  file { '/etc/tomcat/Catalina/localhost/solr.xml':

    content => template('solr-context.xml.erb'),
    require => Exec['install_solr']
  }

  file { '/usr/share/solr/solr.xml':

    path => '',
    content => template('solr.xml.erb'),
    require => Exec['install_solr']
  }

  file { '/usr/share/solr/fedora':

    ensure => "directory",
    owner  => "tomcat",
    group  => "tomcat",
    require => Exec['install_solr']
  }

  # Copy the /collection1/conf into fedora/conf
  

  # Deploy Solr and restart Tomcat
  exec { 'deploy_solr':

    command => "/bin/cp /opt/solr/solr-4.2.0/dist/solr-4.2.0.war /var/lib/tomcat/webapps/solr.war",
    unless => "/usr/bin/stat /var/lib/tomcat/webapps/solr.war",
    require => Exec['solr_add_core_fedora']
  }
}
