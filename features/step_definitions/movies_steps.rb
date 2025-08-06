Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  # ensure that that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

Then(/I should see all the movies/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %(I should see "#{movie.title}")
  end
end

Then(/^the director of "(.+)" should be "(.+)"$/) do |movie, expected_director|
    expect(page).to have_content(expected_director)
end

  
When(/^I follow "Delete" for "(.*)"$/) do |movie_title|
    movie = Movie.find_by(title: movie_title)
    # Assuming you have a delete link or button with id or text that includes the movie's id or title
    # This may need adjustment depending on your actual view markup.
    within("tr#movie_#{movie.id}") do
      click_link("Delete")
    end
end
  