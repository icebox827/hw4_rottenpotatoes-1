# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
  first = page.body.index(e1)
  second = page.body.index(e2)
  assert (first + second) > 0
end


#############################################################################3

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  first = page.body.index(e1)
  second = page.body.index(e2)
  assert (first < second) == true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  
  if uncheck == 'un'
    ratings.each do |r|
      step %Q{I uncheck "ratings_#{r}"}
    end
  else
     ratings.each do |r|
      step %Q{I check "ratings_#{r}"}
    end
  end
  
end


