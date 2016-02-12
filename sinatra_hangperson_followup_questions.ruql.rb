quiz 'Follow-up questions to sanity-check whether students did the Sinatra Hangperson homework on their own' do

  fill_in do
    text 'A Ruby or Rails app specifies the libraries it depends on by listing them in the ---; running the --- program causes any unresolved dependencies to be satisfied by downloading and installing the required libraries.'
    answers [ /gem ?file/i, /bundle/i ]
  end

  choice_answer :randomize => true do
    text 'In a Sinatra app such as the Hangperson app assigned in the homework, how are routes (HTTP verb plus URI) mapped to Ruby code that handles each request type?'
    answer 'There are Sinatra methods corresponding to each verb, and the URI is specified directly in the app'
    distractor 'The verbs and routes are specified in the routes.rb file'
    distractor 'The verbs and routes are specified in the config.ru file used by the rackup command that starts the rack appserver'
  end

  choice_answer do
    text 'Where is the Hangperson game state stored between (stateless) HTTP requests from the player?'
    answer 'In a session cookie'
    distractor 'In the database'
    distractor "In the appserver's memory"
  end

  choice_answer do
    text 'In the Hangperson SaaS code, why do the create-game action and the guess-a-letter action end with a redirect?'
    distractor 'Because actions that modify state must always end with a redirect'
    distractor 'Because actions that modify state should use HTTP POST or PUT, but we can only render a view for actions that use a GET'
    answer 'Because it allows us to re-use existing actions to display the game state after modifying it by creating a new game or guessing a letter'
  end
  
  select_multiple do
    text %q{If the Hangperson SaaS code were incorporated into a true service-oriented architecture in which another service "plays" the game remotely, which of the existing game actions, if any, would NOT be needed?}
    answer 'GET /new'
    distractor 'POST /create'
    distractor 'POST /guess'
  end

  choice_answer do
    text 'In terms of how Cucumber executes scenarios (features), what is the difference between Given, When, and Then steps?'
    distractor 'Only When steps (representing actions to be taken) can modify application state or have side effects, for example via POST requests.'
    distractor 'You must specify at least one Given step before any When or Then steps.'
    answer 'There is no difference in execution; Given, When, and Then are aliases for the same method, provided to make the scenario easier for humans to read.'
  end

  

end
