PetulantOctoLana::Application.routes.draw do

  root 'collection_pages#welcome' # just for now, while there's just one collection

  devise_for :members
  # has to be kinda verby?
  get 'member/locked_scans' => 'desk_pages#locked_by_member'
  get 'member/completed_scans' => 'desk_pages#completed_by_member'
  get 'member/scans' => 'desk_pages#scans_by_member'
  get 'member/notes' => 'desk_pages#notes_by_member'
  get 'member/endnote_notes' => 'desk_pages#endnotes_by_member'
  get 'member/snippet_notes' => 'desk_pages#snippets_by_member'

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
  get '/markup' => 'transcriptions#markup'
  # http://leto.electropoiesis.org:3301/transcriptions/2703/health
  # must be a more railsy way
  get '/transcriptions/:scan_id/:index_term' => 'headings#from_wiki'

  resources :headings do
    collection do
      match 'bulk_create', via: [:post]
    end
    collection do
      get 'the_index'
      get 'orphaned_index'
    end
  end
  # Heading::TYPES.each do |t|
  #   resources t.pluralize.to_sym do
  #   end
  # end

  # index only makes sense for end-notes
  resources :notes do
    # has to be kinda verby?
    collection do
      get 'endnotes', as: :endnote
      get 'snippets', as: :snippet
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
    member do
      # get 'by_seq'
    end
  end
  # get '/by_seq' => 'items#by_seq'

  # TODO terrible choice of names
  get '/serve_up_image/:id' => 'images#serve', as: :serve_up_image
  match '/snap/:id' => 'images#snap', via: [:post], as: :snap
  match '/upload_image/:id' => 'images#upload', via: [:post], as: :upload_image

  get '/archival_finding_aid' => 'finding_aids#type'

  get '/search' => 'search#index'

  # collection_pages grouped together, additional customized pages should be read from db
  # whether these should be in the db or not is debatable
  # ideally should all be given in markdown, though transcribe is special
  # and as such is probably a 'desk' page (i have no idea what i meant by all this)
  ['welcome', 'edition_notice', 'foreword', 'preface'].each { |x| get '/'+x => 'collection_pages#'+x }
  # ...
  # trace = architecure of the collection
  # outline = archaeology of the collection
  # ...
  #
  # desk_pages (needs to be plural)
  # https://stackoverflow.com/questions/646951/singular-or-plural-controller-and-helper-names-in-rails
  #
  # up top (#manage_scans defined above)
  ['desk', 'completed', 'leaderboard', 'faqs_n_guide', 'faqs', 'guide'].each { |x| get '/'+x => 'desk_pages#'+x }
  # down below
  ['legal', 'cite', 'inspiration', 'develop', 'shout_out', 'secretions'].each { |x| get '/'+x => 'desk_pages#'+x }
  # book analogy related
  ['browse', 'item_view', 'outline'].each { |x| get '/'+x => 'desk_pages#'+x }

  # need to be able to dynamically add collection pages based on entries in the control file

  namespace :admin, only: [:index] do
    resources :transcriptions, :images, :collection_pages
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
