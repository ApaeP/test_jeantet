Rails.application.routes.draw do
  root to: "pages#home"
  get '/results', to: "main_forms#results"
  get '/back', to: "main_forms#go_back_to_previous_question"
  resources :main_forms
end
