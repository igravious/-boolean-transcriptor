PetulantOctoLana::Application.routes.draw do

  devise_for :users
  root 'pages#welcome'

  Rails.env.development? and get 'qwux' => 'qwux#new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :transcriptions do
  end

  # index only makes sense for end-notes
  resources :notes do
  end

  resources :items, only: [:index, :show] do
    resources :scans, only: [:index]
    resources :notes, only: [:index]
    collection do
      get 'slice'
    end
  end

  get '/serve_up_image/:id' => 'images#serve'
  match '/portion_of_image/:id' => 'images#portion', via: [:post]

  get '/archival_finding_aid' => 'finding_aids#type'

  get '/search' => 'search#index'

  # pages grouped together, additional user pages should be read from db
  # whether these should be in the db or not is debatable
  # ideally should all be given in markdown, though transcribe is special
  # and as such is probably a 'site' page
  ['welcome', 'transcribe', 'guide', 'intro', 'leader', 'legal', 'stats'].each { |x| get '/'+x => 'pages#'+x }

  # site 
  ['inspiration', 'code', 'acknowledgments', 'secretions'].each { |x| get '/'+x => 'site#'+x }

  # need to be able to dynamically add pages based on entries in the control file

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
