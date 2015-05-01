desc 'Set up the application for development'

task bootstrap: :environment do
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end
