Rails.application.routes.draw do
  get '/gui' => 'gui#top_page'
  post '/accounts/signs' => 'api/signs#create'
end
