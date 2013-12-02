Hoodpopper::Application.routes.draw do
  get "hoodpop/index"
  root 'welcome#index'

  get "welcome/index"

  get "/hoodpop" => 'hoodpop#index'
  post "/hoodpop" => 'hoodpop#index'


end
