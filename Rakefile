require 'bundler/setup'
require 'foodcritic'

#Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }

task :default => [:foodcritic]

task :foodcritic do
	cookbooks = File.absolute_path(File.join File.dirname(__FILE__), 'config-code', 'chef', 'cookbooks')
  linter = FoodCritic::Rake::LintTask.new
  linter.files = cookbooks
end
