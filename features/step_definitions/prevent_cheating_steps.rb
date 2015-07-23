Given(/^I start a new game with word "([^"]*)"$/) do |arg1|

  pending # Write code here that turns the phrase above into concrete actions

end

When(/^I try to go to the URL "([^"]*)"$/) do |arg1|

  pending # Write code here that turns the phrase above into concrete actions

end

Then /^(?:|I )should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
   	if current_path.respond_to? :should
    	current_path.should == path_to(page_name)
   	else
    	assert_equal path_to(page_name), current_path
  	end
end