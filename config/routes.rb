Rails.application.routes.draw do

  resources :teams, only: [:index, :show] do
    collection { post :import}
  end

  resources :runners, only: :index do
    collection { post :import}
  end

end
