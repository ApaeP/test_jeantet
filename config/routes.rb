Rails.application.routes.draw do
  # root to: "pages#home"
  root to: "main_forms#new"
  resources :main_forms do
    get '/back', to: "main_forms#go_back_to_previous_question"
    get '/results', to: "main_forms#results"
  end
end
