require 'bundler/setup'
require 'rspec/core/rake_task'

def install_tasks(opts = nil)
  dir = caller.find{|c| /Rakefile:/}[/^(.*?)\/Rakefile:/, 1]
  h = Bundler::GemHelper.new(dir, opts && opts[:name])
  h.install
  h
end
helper = install_tasks
spec = helper.gemspec

require 'rake/clean'
CLEAN.include 'pkg'

task :git_local_check do
  sh "git diff --no-ext-diff --ignore-submodules --quiet --exit-code" do |ok, _|
    raise "working directory is unclean" if !ok
    sh "git diff-index --cached --quiet --ignore-submodules HEAD --" do |ok, _|
      raise "git index is unclean" if !ok
    end
  end
end
task :build => :git_local_check

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
