Rails.application.routes.draw do
  root to: "pages#home"
  resources :main_forms
end
