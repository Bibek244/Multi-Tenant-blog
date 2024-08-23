Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "organizations#index"


  devise_for :users, controllers: { registrations: 'registrations' , sessions: 'sessions'}
  resources :organizations do
    resources :posts do 
      resources :comments, only: [:create]
    end
    resources :memberships 
  end

  resources :profiles, only: [:new, :create, :show, :edit, :update, :destroy]
end
