namespace :db do

  task :nuke_and_pave => :guarded_environments do
    `rm #{Rails.root}/db/schema.rb`
    Rake::Task["db:drop:all"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end

  # uncomment this if you need your seeds for testing.  Typically only necessary
  # if your application *needs* seed data to function - like static pages or
  # lists of cities and states, that kind of thing.
  # namespace :test do
  #   task :prepare do
  #     Rake::Task["db:seed"].invoke
  #   end
  # end

end