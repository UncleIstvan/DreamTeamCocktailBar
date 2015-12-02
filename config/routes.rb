Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  resources :welcome, only: [:show]
  get 'cocktail/:id' => 'welcome#show', as: :purchase
  get 'search_by_product/:product_name' => 'welcome#search_by_product', as: :search_product
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):



  # Example resource route with options:


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
     namespace :admin do

       resources :sessions, only: [:new, :create, :destroy]
       match '/signin', to: 'sessions#new', via: 'get'
       match '/signout', to: 'sessions#destroy', via: 'delete'
       match '/signup', to: 'users#new', via: 'get'
       resources :users, :products, :ingredients

       # get '/cocktails/sort_by/:type' => 'cocktails#sort_by', as: :sort_by
       # get '/products/sort_by/:type' => 'products#sort_by', as: :products_sort_by

       get 'cocktails_sort_by/:type' => 'cocktails#sort_by', as: :cocktails_sort_by
       get 'products_sort_by/:type' => 'products#sort_by', as: :products_sort_by


       resources :cocktails do
         resources :ingredients
       end




  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products


       resources :products, :cocktails do

         collection do
           get 'search'
         end
       end

     end

  namespace :api do

    namespace :v1 do

      resources :ingredients

      resources :cocktails do
        resources :ingredients
      end

    end

  end

end
