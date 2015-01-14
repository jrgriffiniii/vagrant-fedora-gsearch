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
  $install_dir_path = '/usr/share/solr'

  $host = 'localhost'
  $port = '8080'

  # Islandora/Fedora Generic Search is documented as supporting Solr 4.2.0
  # For Solr 4.2.0
#  class { "::solr":

#    install_source => 'http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz',
#    require => Tomcat::Instance['default']
#  }

  class { "::fedora_commons_solr": }
}
