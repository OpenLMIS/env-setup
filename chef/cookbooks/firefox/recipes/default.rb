#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 

ff_pkg = case when node['platform_version'].to_f >= 6.0
   %w{dbus-x11 firefox libXrandr abyssinica-fonts cjkuni-uming-fonts dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts jomolhari-fonts khmeros-base-fonts kurdit-unikurd-web-fonts liberation-mono-fonts liberation-sans-fonts liberation-serif-fonts lklug-fonts lohit-assamese-fonts lohit-bengali-fonts lohit-devanagari-fonts lohit-gujarati-fonts lohit-kannada-fonts lohit-oriya-fonts lohit-punjabi-fonts lohit-tamil-fonts lohit-telugu-fonts madan-fonts paktype-naqsh-fonts paktype-tehreer-fonts sil-padauk-fonts smc-meera-fonts stix-fonts thai-scalable-waree-fonts tibetan-machine-uni-fonts un-core-dotum-fonts vlgothic-fonts wqy-zenhei-fonts aajohan-comfortaa-fonts bitmap-fixed-fonts bitmap-lucida-typewriter-fonts cjkuni-fonts-ghostscript}
else 
  %w{dbus-x11 firefox libXrandr}
end

ff_pkg.each do |pkg|
  package pkg do
    action :install
    ignore_failure true
  end
end

execute "Add dbus-launch to Firefox startup" do
  command "sed -i 's/exec $MOZ_LAUNCHER/exec dbus-launch $MOZ_LAUNCHER/g' /usr/bin/firefox"
  action :run
  not_if "grep 'exec dbus-launch $MOZ_LAUNCHER' /usr/bin/firefox"
end
