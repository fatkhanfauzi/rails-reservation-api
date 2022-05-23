Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :reservations, except: [:new, :edit], param: :uuid
  end
end
