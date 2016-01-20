require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList['spec/**/*_spec.rb']
end

task :default => :test

require 'fileutils'
include FileUtils

# rake provision[Farble,farble]
desc "make a new cli"
task :provision, [:classname, :gemname] do |t, args|
  gemname = args[:gemname]
  classname = args[:classname]
  puts "--> Generating #{gemname}..."

  replacements = {
      "tinycli" => gemname,
      "Tinycli"  => classname
  }
  files = %w{ bin/tinycli
      lib/tinycli/version.rb
      lib/tinycli.rb
      spec/tinycli_spec.rb
      spec/spec_helper.rb
      tinycli.gemspec }

  files.each do |file|
    sed file, replacements
  end


  mkdir "lib/#{gemname}"
  files.each do |file|
    target = file.gsub("tinycli", replacements["tinycli"])
    mv file, target if file != target
  end
  rmdir "lib/tinycli"

  `rm -rf .git`
  `git init .`
  `git add .`
  `git commit -am 'initial commit'`
  puts "\n\n--> Running a test of #{gemname} --help\n\n"
  puts `ruby -Ilib bin/#{gemname} --help`
  
  puts "\n\n--> Done provisioning CLI gem: #{gemname}.\n--> You can now create Github repo when you like."
  
end

def sed(file, replacements)
  content = File.read(file)
  replacements.each do |old,new|
    content.gsub!(old, new)
  end
  File.open(file, "w") do |f|
    f.write(content)
  end
end

