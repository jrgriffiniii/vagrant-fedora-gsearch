# Class: fedoragsearch
#

class fedoragsearch (

  $catalina_home = params_lookup( 'catalina_home' ),
  
  $fedora_home = params_lookup( 'fedora_home' ),

  $install_source = params_lookup( 'install_source' ),
  $install_destination = params_lookup( 'install_destination' ),
  ) inherits fedoragsearch::params {

    $fedora_users = "${fedora_home}/server/config/fedora-users.xml",
    
    $home = "${install_destination}/webapps/fedoragsearch"
    # $fedoragsearch_properties = "${fedora_home}/tomcat/webapps/fedoragsearch/FgsConfig/fgsconfig-basic-for-islandora.properties"
    $properties = "${home}/FgsConfig/fgsconfig-basic-for-islandora.properties"
    $fedoragsearch_schema = "${fedora_home}/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/conf/schema-4.2.0-for-fgs-2.6.xml"
    $solr_schema = "${home}/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/conf/schema-4.2.0-for-fgs-2.6.xml"
    

    exec { 'fedoragsearch_download':

      command => "/usr/bin/wget ${fedoragsearch::install_source} -O /tmp/fedoragsearch.zip",
      unless => '/usr/bin/stat /tmp/fedoragsearch.zip'
    }

    exec { 'fedoragsearch_decompress':

      command => '/usr/bin/unzip /tmp/fedoragsearch.zip -d ${fedoragsearch::install_destination}'
    }

    file_line { 'fedoragsearch_fedora_add_user':

      path => "${fedora_users}",
      line => template('fedoragsearch/fedora-users.xml.erb')
    }

  exec { 'fedoragsearch_insert_properties':
    
    command => "/usr/bin/sed -i ${fedoragsearch_build} 's#property file=\"fgsconfig-basic.properties#property file=\"fgsconfig-basic-for-islandora.properties#'",
    unless => "/usr/bin/grep -q 'for-islandora' ${fedoragsearch_build}"
  }

  exec { 'fedoragsearch_ant_build':
    
    command => "/usr/bin/ant -f ${fedoragsearch_build}",
    unless => "/usr/bin/stat ${fedoragsearch_schema}"
  }

  file { 'fedoragsearch_tomcat_create_context':

    path => "$catalina_home/conf/Catalina/localhost/fedoragsearch.xml",
    content => template('fedoragsearch/fedoragsearch.xml.erb')
  }
}
