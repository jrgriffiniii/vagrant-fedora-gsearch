# == Class: profile::solr
#
# Solr profile
#
class profile::solr {

  # For Solr 4.10.3
  class { "solr":

    install_source => 'http://apache.mesi.com.ar/lucene/solr/4.10.3/solr-4.10.3.tgz'
  }
}
