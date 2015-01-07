# == Class: role::discovery
#
# Discovery role
#
class role::discovery {
  
  include profile::base
  include profile::java
  include profile::tomcat
  include profile::solr
  # include profile::fedoragsearch
}
