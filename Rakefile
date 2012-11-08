require 'bundler/setup'
require 'puppet-lint'

#Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }

PuppetLint.configuration.log_format = '%{path}:%{linenumber} - %{KIND}: %{message}'
PuppetLint.configuration.send('disable_80chars')

task :default => [:simplelint, :validate]

task :simplelint do
  linter = PuppetLint.new
  PuppetLint.configuration.send("disable_documentation")
  Dir['**/**/**/*.pp'].each do |pp|
    linter.file = pp
    linter.run
  end
  fail if linter.errors?
end

desc 'Validates the syntax of the puppet manifest files'
task :validate do
  puts `puppet parser validate #{Dir['**/**/**/*.pp'].join(' ')}`
  fail unless $?.to_i == 0
end

