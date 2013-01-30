cookbook_file "#{node["webapp"]["home"]}/apache-tomcat-7.0.33/conf/server.xml" do 
	source "server.xml"
	group "openlmis"
	owner "openlmis"
	mode "0600"
	action :create
end
