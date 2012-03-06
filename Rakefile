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
task :release => :git_local_check
task :build => :git_local_check

class MyRSpec < RSpec::Core::RakeTask
  def task(*args,&block)
    super(*args) do
      old, ENV['RUBYOPT'] = ENV['RUBYOPT'], "#{ENV['RUBYOPT']} #{ruby_opts}"
      yield
      ENV['RUBYOPT'] = old
    end
  end
end

MyRSpec.new("spec:1.8") do |t|
  t.ruby_opts = '--1.8'
end
MyRSpec.new("spec:1.9") do |t|
  t.ruby_opts = '--1.9'
end
task :spec => ["spec:1.8", "spec:1.9"]
task :test => :spec
task :default => :spec
