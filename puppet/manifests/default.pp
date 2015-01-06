
# Deprecated; Work-around for Vagrant
import 'profiles/*.pp'
import 'roles/*.pp'

node /^discovery\d*/ {
  
  include role::discovery
}

node default { }
