Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
      resources :categories
      resources :products
      # GET POST /admin/v1/games/:game_id/licences  <<= listar e cadastrar id_game
      # GET PATCH DELETE /admin/v1/licenses/:id
      resources :games, only: [], shallow: true do
        resources :licenses
      end
    end
  end

  namespace :storefront do
    namespace :v1 do
    end
  end
end

