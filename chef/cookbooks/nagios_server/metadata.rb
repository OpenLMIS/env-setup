maintainer       "ThoughtWorks - DevOps Team"
maintainer_email "devops-in@thoughtworks.com"
license          "ThoughtWorks OpenSource license"
description      "Installs/Configures the Nagios server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

depends "httpd"
depends "nagios_server_theme"
