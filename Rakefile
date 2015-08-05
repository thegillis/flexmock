# Rakefile for flexmock        -*- ruby -*-

#---
# Copyright 2003, 2004, 2005, 2006, 2007 by Jim Weirich (jim@weirichhouse.org).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#+++
task :noop
require 'rubygems'
require 'rake/clean'
require 'rake/testtask'

require 'rubygems/package_task'

CLEAN.include('*.tmp')
CLOBBER.include("html", 'pkg')

load './lib/flexmock/version.rb'

PKG_VERSION = FlexMock::VERSION

EXAMPLE_RB = FileList['doc/examples/*.rb']
EXAMPLE_DOC = EXAMPLE_RB.ext('rdoc')

CLOBBER.include(EXAMPLE_DOC)
CLEAN.include('pkg/flexmock-*').exclude("pkg/*.gem")

task :default => [:test_all, :rspec, :minitest]
task :test_all => [:test]
task :test_units => [:test]
task :ta => [:test_all]

# Test Targets -------------------------------------------------------

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.libs << "."
  t.verbose = false
  t.warning = true
end

module Configuration
  def self.minitest?
    require 'minitest/autorun'
    return true
  rescue Exception
    return false
  end
end

task :testunit do
  files = FileList['test/test_unit_integration/*_test.rb']
  if ! Configuration.minitest?
    files = files.reject { |fn| fn =~ /minitest/ }
  end
  files.each do |file|
    sh "ruby -Ilib:. #{file}"
  end
end

task :minitest do
  files = FileList['test/minitest_integration/*_test.rb']
  files.each do |file|
    sh "ruby -Ilib:. #{file}"
  end
end

task :rspec do
  sh "rspec test/rspec_integration"
end

# Coverage Target --------------------------------------------------------

task 'coverage' do
  ENV['COVERAGE'] = 1
  Rake::Task[:test].invoke
end

# Documentation Target --------------------------------------------------------

require 'yard'
require 'yard/rake/yardoc_task'
EXAMPLE_RB.zip(EXAMPLE_DOC).each do |source, target|
  file target => source do
    open(source, "r") do |ins|
      open(target, "w") do |outs|
        outs.puts "= FlexMock Examples"
        ins.each do |line|
          outs.puts "    #{line}"
        end
      end
    end
  end
end
YARD::Rake::YardocTask.new(:doc => [*EXAMPLE_RB, "README.md"])

file "README.md" => ["Rakefile", "lib/flexmock/version.rb"] do
  ruby %{-i.bak -pe '$_.sub!(/^Version: *((\\d+|beta|rc)\\.)+\\d+ *$/i, "Version :: #{PKG_VERSION}")' README.md} # "
end

# Package Task -------------------------------------------------------

task :specs do
  specs = FileList['test/spec_*.rb']
  ENV['RUBYLIB'] = "lib:test:#{ENV['RUBYLIB']}"
  sh %{rspec #{specs}}
end

task :tag do
  sh "git tag 'flexmock-#{PKG_VERSION}'"
end
