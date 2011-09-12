Cgdv::Application.routes.draw do
  devise_for :users, :path_prefix => 'd',:controllers => { :registrations => "registrations" }
  resources :users
  
  resources :timereports
  
  resources :donors do
    resources :telephones, :addresses, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end
  
  resources :notes do
    get :print, :on => :member	
  end
  resources :patients do
    member do
      get 'print', 'notas'
    end
  	resources :addresses, :telephones, :emails, :derechohabientes, :apoyos, :tratamientos, :comments, :diagnosticos, :refclinicas, :houses, :socioecos, :family_members, :addinfos, :only => [:new, :edit, :update, :create, :destroy] 
  end

  resources :volunteers do
  	member do
  	  get 'trep'
  	end
    resources :addresses, :telephones, :emails, :comments, :addinfos, :subprograms, :diagnosticos, :dailyschedules, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :providers do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :contacts do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end
  
  root :to => "pages#home"

end
