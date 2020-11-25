Rails.application.routes.draw do
  root to: "pages#home"
  get "begin", to: "main_forms#new"
end
