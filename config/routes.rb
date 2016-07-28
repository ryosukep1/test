Rails.application.routes.draw do
  get '/gui' => 'gui#top_page'
  post '/accounts/signs' => 'api/signs#create'
  delete '/accounts/signs' => 'api/signs#delete'
  get '/accounts' => 'api/accounts#index'
end
