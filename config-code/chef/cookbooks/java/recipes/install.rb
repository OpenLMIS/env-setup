# java::install

case node.platform
when "centos", "redhat", "amazon", "scientific"
  $java_package = 'java-1.6.0-openjdk'

else
  $java_package = 'java'

end

package $java_package
