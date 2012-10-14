#!/usr/bin/env ruby
#
# all this GitHub TGZ stuff so no dependency on Git
# as for nodes where policies don't allow dev-tools
#

GITHUB_TGZ   = 'https://github.com/OpenLMIS/env-setup/tarball/master'
GITHUB_LOCAL = '/tmp/github_openlmis_envsetup.tgz'
CHEF_HOME    = '/opt/chef'

module Sys
  def self.mkdir(path)
  	Dir.mkdir path unless File.exists? path
  end

	def self.download(url, local_file)
		log %x{#{sudo} wget -c -O #{local_file} #{url}}
	end

	def self.untar_to_chef(tgz, untar_path)
		err('No GitHub TGZ Found.') unless File.exists? tgz
		tgz_base = File.dirname tgz

		mkdir untar_path
		log %x{#{sudo} tar -zxvf tgz OpenLMIS-env-setup*/config-code/chef}
		log %x{#{sudo} mv #{tgz_base}/OpenLMIS-env-setup*/config-code/chef/* #{untar_path}}
	end

	def self.cleanup_chef(untar_path)
		cookbooks_path = File.join untar_path, 'cookbooks'
		hotplate_path  = File.join untar_path, 'hotplate'
		log %x{#{sudo} rm -rf #{cookbooks_path}}
		log %x{#{sudo} rm -rf #{hotplate_path}}
	end

	def self.log(data)
		if ENV['LMIS_LOG'].nil?
			puts data
		end
	end

	def self.err(msg); puts msg && exit 1; end

	def self.sudo
		ENV['NOSUDO'].nil? ? 'sudo' : '' 
	end
end

module EnvSetup
	def self.chef_prep
		begin
			Sys.download GITHUB_TGZ, GITHUB_LOCAL
			Sys.cleanup_chef CHEF_HOME
			Sys.untar_to_chef GITHUB_LOCAL, CHEF_HOME
		rescue
			Sys.err 'Chef Prep Failed.'
		end
	end

	def self.cook(role)
		return help('Node Role sent to be applied.') if role.nil?
		chef_prep
		solo_config = File.join CHEF_HOME, 'hotplate', 'solo_config.rb'
		node_json   = File.join CHEF_HOME, 'hotplate', 'run_lists', '#{role}.json'
		return help('No Chef-Solo Config Found.') unless File.exists?(solo_config)
		return help('No Node JSON Found.') unless File.exists?(node_json)

		Sys.log %x{#{Sys.sudo} chef-solo -c #{solo_config} -j #{node_json}}
	end

	def self.help(err_or_warn)
		Sys.log err_or_warn # would modify it
	end
end

case ARGV[0]
when /cook/
  EnvSetup.cook ARGV[1]

else
	Sys.log 'No Action Provided.'
end