# == Class: role::discovery
#
# Discovery role
#
class role::discovery {
  
  include profile::base
  include profile::solr
  include profile::fedora_commons
  include profile::fedoragsearch
}
