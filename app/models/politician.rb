require_relative '../../db/config'
# This requires Active Record

# This is the Active Record MODEL of the database

class Politician < ActiveRecord::Base

# This is where all the modeling magic happens

end

class Representative < Politician; end

class Senator < Politician; end