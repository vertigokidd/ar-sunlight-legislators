require 'rake'
require 'rspec/core/rake_task'
require 'csv'
require_relative 'db/config'


task 'db:console' do
  exec "irb -r./db/config.rb"
end


desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "seed the database"
task "db:seed" do
	require_relative 'app/models/politician.rb'
	csv = CSV.new(File.open('db/data/legislators.csv'), :headers => true, :header_converters => :symbol)
	csv.each do |row|
	  # row.each do |field, value|
	    # TODO: begin
	    # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
	    # TODO: end
	    if row[:title] == 'Rep'
	      Representative.create(  :title       => row[:title],
			    	              :firstname   => row[:firstname],
			                      :middlename  => row[:middlename],
			                      :lastname    => row[:lastname],
			                      :name_suffix => row[:name_suffix],
			                      :gender      => row[:gender],
			                      :party       => row[:party],
			                      :in_office   => row[:in_office],
			                      :state       => row[:state],
			                      :district    => row[:district],
			                      :phone       => row[:phone],
			                      :fax         => row[:fax],
			                      :website     => row[:website],
			                      :webform     => row[:webform],
			                      :district    => row[:district],
			                      :birthdate   => row[:birthdate],
			                      :twitter_id  => row[:twitter_id]
			                    )
	    else
	      Senator.create( :title       => row[:title],
	    	              :firstname   => row[:firstname],
	                      :middlename  => row[:middlename],
	                      :lastname    => row[:lastname],
	                      :name_suffix => row[:name_suffix],
	                      :gender      => row[:gender],
	                      :party       => row[:party],
	                      :in_office   => row[:in_office],
	                      :state       => row[:state],
	                      :district    => row[:district],
	                      :phone       => row[:phone],
	                      :fax         => row[:fax],
	                      :website     => row[:website],
	                      :webform     => row[:webform],
	                      :district    => row[:district],
	                      :birthdate   => row[:birthdate],
	                      :twitter_id  => row[:twitter_id]
		                )
	    end
	end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
