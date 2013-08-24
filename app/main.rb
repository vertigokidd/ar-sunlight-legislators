require_relative 'models/politician.rb'
require_relative 'twitter/twitter.rb'


def list_politicians_by_state(state)
  search_term = state.upcase
  pols_list = Politician.select(:title, :firstname, :lastname, :party).where('state' => search_term).order("title desc")
  count = 0
  pols_list.each do |poli|
    count += 1
    if count == 1
  	  puts "Senators:"
    elsif count == 3
  	  puts "Representatives:"
    end
    print '    ' + poli.title + ' '
    print poli.firstname + ' '
    print poli.lastname + ' '
    print "(#{poli.party})"
    puts
  end
end


def list_twitter_ids(state)
  search_term = state.upcase
  pols_list = Politician.select(:id, :title, :firstname, :lastname, :party, :twitter_id).where('state' => search_term).order("title desc")
  count = 0
  pols_list.each do |poli|
    count += 1
    if count == 1
  	  puts "Senators:"
    elsif count == 3
  	  puts "Representatives:"
    end
    print "ID:#{poli.id}"
    print '  ' + poli.title + ' '
    print poli.firstname + ' '
    print poli.lastname + ' '
    print "(#{poli.party})" + ' : '
    if poli.twitter_id != ''
      print '@' + poli.twitter_id
    else
      print 'No Twitter Handle'
    end
    puts
  end
end


def find_gender_percent(gender)
  search_term = gender.upcase
  # if search_term != 'M' || search_term != 'F'
  #   raise 'Not a valid search term, M or F'
  # end
  senator_gender_count = Politician.where('gender' => search_term, 'title' => 'Sen', 'in_office' => 1).count
  total_senator_count = Politician.where('title' => 'Sen', 'in_office' => 1).count

  rep_gender_count = Politician.where('gender' => search_term, 'title' => 'Rep', 'in_office' => 1).count
  total_rep_count = Politician.where('title' => 'Rep', 'in_office' => 1).count

  puts search_term + ' Senators: ' + "#{senator_gender_count}" + "  #{(senator_gender_count.to_f / total_senator_count * 100).to_i}%"
  puts search_term + ' Reps    : ' + "#{rep_gender_count}" + "  #{(rep_gender_count.to_f / total_rep_count * 100).to_i}%"

end


def list_state_pol_count
  reps_hash = Politician.select(:state).where('title' => 'Rep', 'in_office' => 1).group('state').count
  reps_hash_desc = reps_hash.sort_by { |k,v| v }.reverse
  puts "Congresspeople Count By State:"
  reps_hash_desc.each do |k, v|
    puts "#{k}: 2 Senators, #{v} Representatives"
  end
end


def list_recent_tweets(poli_id)
  poli = Politician.find_by('id' => poli_id)
  twitter_handle = poli.twitter_id
  t = Tweet.new(twitter_handle)
  t.tweets.each do |mapping|
    # mapping.each do |k, v|
    puts mapping['text']
    puts "tweeted at: #{mapping['created_at']}"
      # if k == 'text'
      #   puts v
      # end
    # end
    puts
  end
end



### DRIVER CODE ###

# list_politicians_by_state('hi')
# list_twitter_ids('il')
list_recent_tweets(521)
# find_gender_percent('f')
# find_gender_percent('m')


### TESTS ###

# poli = Politician.find(10)
# p poli


# List politicians by state, starting with Senators first:

# cali = Politician.select(:title, :firstname, :lastname, :party).where('state' => 'CA').order("title desc")
# ill = Politician.select(:title, :firstname, :lastname, :party).where('state' => 'IL').order("title desc")


# count = 0
# ill.each do |poli|
#   count += 1
#   if count == 1
#   	puts "Senators:"
#   elsif count == 3
#   	puts "Representatives:"
#   end
#   print '    ' + poli.title + ' '
#   print poli.firstname + ' '
#   print poli.lastname + ' '
#   print "(#{poli.party})"
#   puts
# end


# p Politician.where('gender' => 'M', 'title' => 'Sen', 'in_office' => 1).count
# p Politician.where('title' => 'Sen', 'in_office' => 1).count

# This creates a hash of all states with their number of reps currently in office
# reps_hash = Politician.select(:state).where('title' => 'Rep', 'in_office' => 1).group('state').count
# p reps_hash.sort_by { |k,v| v }.reverse
# p reps_hash

# list_state_pol_count




