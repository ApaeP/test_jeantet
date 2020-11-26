Rails.application.routes.draw do
  root to: "pages#home"
  get '/results', to: "main_forms#results"
  resources :main_forms
end
