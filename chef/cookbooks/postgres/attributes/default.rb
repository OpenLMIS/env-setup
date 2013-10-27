#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 
node.set["postgreSQL"]={}
node.set["postgreSQL"]["allowSubnet"]=["192.168.34.0/24", "10.15.6.0/24"]
node.set["postgreSQL"]["archivedir"]='/var/lib/pgsql/9.1/archive'
node.set["postgreSQL"]["slaveSubnet"]=["54.251.253.0/23"]
node.set["postgreSQL"]["home"]='/var/lib/pgsql/9.1/'
