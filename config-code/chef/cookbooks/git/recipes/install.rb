# java::install

case node.platform
when "centos", "redhat", "amazon", "scientific"
  $git_package = 'git'

else
  $git_package = 'git'

end

package $git_package
