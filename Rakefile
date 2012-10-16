require 'bundler/setup'
require 'foodcritic'

#Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }

task :default => [:foodcritic]

task :foodcritic do
	cookbooks = File.absolute_path(File.join File.dirname(__FILE__), 'config-code', 'chef', 'cookbooks')
  puts 'FoodCritic running...
        would criticize if finds anything, not cycnical to blabber otherwise.'
  result = FoodCritic::Linter.new.check cookbooks, {}
  puts result
  fail if result.failed?
end
