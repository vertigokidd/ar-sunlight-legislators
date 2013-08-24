require 'csv'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      # row.each do |field, value|
        # TODO: begin
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        # TODO: end
        Politician.create(:first_name  => row[:first_name],
                          :middle_name => row[:middle_name],
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
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
