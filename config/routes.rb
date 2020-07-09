Cgdv::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
	
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: :get

  resources :donations

  resources :activity_reports do
    resources :comments, :only => [:new, :edit, :update, :create, :destroy]
  end

  devise_for :users, :path_prefix => 'd',:controllers => { :registrations => "registrations" }
  resources :users do
  member do
  	  get 'image'
  	end	
  end
  
  resources :timereports
  resources :vol_times

  resources :addresses do
    get :autocomplete_catestado_estado, :on => :collection
  end
  
  resources :donors do
    resources :telephones, :addresses, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end
  
  resources :notes do
  	member do
  	  get 'print', 'image'
  	end
    resources :attachments do
  		member do
  	  	get 'image'
  		end
  	end
  end
  
  resources :attachments do
  	member do
  	  get 'image'
  	end
  end
  
  resources :patients do
    member do
      get 'print', 'notas'
    end
  	resources :addresses, :telephones, :emails, :derechohabientes, :apoyos, :tratamientos, :comments, :diagnosticos, :refclinicas, :houses, :socioecos, :family_members, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  	
  	resources :attachments do
  		member do
  	  	get 'image'
  		end
  	end 
  
  	
	end

  resources :volunteers do
  	member do
  	  get 'trep', 'image'
  	end
    resources :addresses, :telephones, :emails, :comments, :addinfos, :subprograms, :diagnosticos, :dailyschedules, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :providers do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :contacts do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end
  
  root :to => "pages#home", via: :get
  match '/times', :to => "pages#times", via: :get

end
