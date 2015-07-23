When /^I start a new game with word "(.*)"$/ do |word|
  stub_request(:post, "http://watchout4snakes.com/wo4snakes/Random/RandomWord").
    to_return(:status => 200, :headers => {}, :body => word)
  visit '/new'
  click_button "New Game"
end

When /^I try to go to the URL "(.*)"$/ do |url|
  visit url
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
   	if current_path.respond_to? :should
    	current_path.should == path_to(page_name)
   	else
    	assert_equal path_to(page_name), current_path
  	end
end