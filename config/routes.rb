Rails.application.routes.draw do

  resources :teams, only: [:show] do
    collection { post :import }
  end

  resources :runners, only: :index do
    collection { post :import }
  end

  resources :config, only: [:index, :show, :update] do
    collection do
      post :load
      post :persist
    end
  end

  get "results/classes" => "results#classes"

  get "results/awt" => "results#awt"

  get "results/teams" => "results/teams"

  get "results/awards" => "results/awards"

  post "results/clear" => "results/clear"

  get "teams2" => "teams2#index"

  get "awards" => "awards#index"

end
