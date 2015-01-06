# Class: fedoragesearch::params
#
# This class defines default parameters used by the module class fedoragsearch

class fedoragsearch::params {

  $servlet_engine = 'tomcat'
  $catalina_home = $::tomcat::catalina_home
  $jetty_home = "${::jetty::home}/jetty-distribution-${::jetty::version}"
  $fedora_home = '/usr/local/fedora'

  $install_source = "http://downloads.sourceforge.net/fedora-commons/fedoragsearch-2.7.zip"

  $install_destination = $servlet_engine ? {

    jetty => "${jetty_home}/webapps",
    default => "${catalina_home}/webapps"
  }

  $config_display_name = 'configProductionSolr'
  $gsearch_base = 'http://localhost:8080'
  $gsearch_app_name = 'fedoragsearch'

  $gsearch_user = 'fgsAdmin'
  $gsearch_pass = 'secret'

  $final_config_path = "${install_destination}/${gsearch_app_name}/WEB-INF/classes"

  $log_file_path = "${fedora_home}/server/logs"
  $log_level = 'DEBUG'

  $name_of_repositories = "FgsRepos"
  $names_of_indexes = "FgsIndex"
  $fedora_base = "http://localhost:8080"
  $fedora_app_name = "fedora"

  $fedora_user = "fedoraAdmin"
  $fedora_pass = "secret"

  $fedora_version = "3.8.0"

  $object_store_base = "${fedora_home}/data/objectStore"
  $index_engine = 'Solr'
  $index_base = "${::solr::url_check}" # @todo Handle cases where the example42/solr Module is not available

  $index_dir = "${::solr::data_dir}/index" # @todo Handle cases where the example42/solr Module is not available
  $indexing_doc_xslt = "foxmlToSolr"
}
