PetulantOctoLana::Application.routes.draw do

  root 'pages#welcome'

  devise_for :members
  get 'members/locked_scans' => 'pages#locked_by_member'

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
    # member do
    #   get :index_term
    # end
  end
  # http://leto.electropoiesis.org:3301/transcriptions/2703/health
  # must be a more railsy way
  get '/transcriptions/:scan_id/:index_term' => 'headings#from_wiki'

  resources :headings do
    collection do
      match 'bulk_create', via: [:post]
    end
  end
  Heading::TYPES.each do |t|
    resources t.pluralize.to_sym do
    end
  end

  # index only makes sense for end-notes
  resources :notes do
    collection do
      get 'scribbled'
      get 'snapped'
    end
  end

  # concern :notable do
  #      resources :notes
  # end
   
  # concern :snippet_attachable do
  #      resources :snippets
  # end

  # concern :citable do
  #      resources :references
  # end

  resources :items, only: [:index, :show] do
    resources :scans, only: [:index]
    resources :notes, only: [:index]
    collection do
      get 'slice'
    end
  end

  get '/serve_up_image/:id' => 'images#serve'
  match '/snap/:id' => 'images#snap', via: [:post]
  match '/upload_image/:id' => 'images#upload', via: [:post]
  get '/markup' => 'images#markup'

  get '/archival_finding_aid' => 'finding_aids#type'

  get '/search' => 'search#index'

  # pages grouped together, additional customized pages should be read from db
  # whether these should be in the db or not is debatable
  # ideally should all be given in markdown, though transcribe is special
  # and as such is probably a 'site' page
  ['welcome', 'browse', 'guide', 'intro', 'leader', 'legal', 'info', 'plan'].each { |x| get '/'+x => 'pages#'+x }
  # ...
  # info = architecure of the collection
  # plan = archaeology of the collection
  # ...
  #
  # site (needs to be plural for symmetry?)
  ['inspiration', 'code', 'acknowledgments', 'secretions'].each { |x| get '/'+x => 'site#'+x }

  # need to be able to dynamically add pages based on entries in the control file

  namespace :admin, only: [:index] do
    resources :transcriptions, :images, :pages
  end

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
