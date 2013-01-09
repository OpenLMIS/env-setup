require 'rubygems'

task :default => [:unit_test]

desc "Run Unit test on each cookbook."
task :unit_test do
  sh "rspec ./chef/cookbooks/**/spec/*_spec.rb"
end
