Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  # Example of regular route:
  get 'what_is/'  => 'static_pages#what_is'
  get 'faq/'      => 'static_pages#faq'
  get 'contact/'  => 'contacts#new'
  get 'coming_soon/'  => 'static_pages#coming_soon'
  get 'creating_skills_help/'  => 'static_pages#creating_skills_help'

  get 'dashboard/' => 'dashboards#show'

  resources "contacts", only: [:new, :create]

  resources :skills do
    # put 'archived', on: :member
    resources :comments
    collection do
      resources :apprenticeships do
        resources :comments

        # resources :confirmations, on: :member, as: 'accept_date', only:[:new, :update, :delete]
      end
      get 'teaching'
      get 'learning'
      get 'archived'
    end
  end

  resources :paths do

  end

  # resources :users
  resources :users do
    collection do
      get 'teaching'
      get 'learning'
    end
  end
  resources :skill_requests do
    # resources :confirmations, on: :member, as: 'accept_date', only:[:new, :update, :delete, :create]
  end
  resources :confirmations, on: [:apprenticeships,:skill_requests], as: 'accept_date', only:[:new, :update, :delete, :create]
  resources :categories
  resources :locations
  resources :notifications
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
