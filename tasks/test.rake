namespace :test do

  begin
    require "rspec/core/rake_task"
    desc "Run RSpec code examples"
    RSpec::Core::RakeTask.new(:unit) do |t|
      t.pattern = "spec/**/test_*.rb"
      t.rspec_opts = ["--color", "--backtrace"]
    end
  rescue LoadError => ex
    task :unit do
      abort 'rspec is not available.'
    end
  end

  begin
    require 'cucumber'
    require 'cucumber/rake/task'

    Cucumber::Rake::Task.new(:cucumber) do |t|
      t.cucumber_opts = "features --format pretty"
    end
  rescue LoadError => ex
    task :unit do
      abort 'cucumber is not available.'
    end
  end

  task :all => [ :unit, :cucumber ]
end
task :test => :'test:all'