Rails.application.routes.draw do

  resources :teams, only: [:show] do
    collection { post :import }
  end

  resources :runners, only: :index do
    collection { post :import }
  end

  resources :config, only: [:index, :show, :update] do
    collection { post :persist }
  end

  get "results/classes" => "results#classes"

  get "results/awt" => "results#awt"

  get "results/teams" => "results/teams"

  get "results/awards" => "results/awards"

  post "results/clear" => "results/clear"

end
