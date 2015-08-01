require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << 'lib'
  task.libs << 'challenges'
  task.test_files = FileList['challenges/challenge_*.rb']
end

task default: :test
