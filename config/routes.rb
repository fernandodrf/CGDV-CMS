Cgdv::Application.routes.draw do
	
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
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
    resources :addresses, :telephones, :emails, :comments, :addinfos, :subprograms, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :providers do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end

  resources :contacts do
    resources :addresses, :telephones, :emails, :comments, :addinfos, :only => [:new, :edit, :update, :create, :destroy]
  end

  #match '/patient',	:to =>'pages#patient'
  #match '/patient',	:to =>'patients#new'
  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => "pages#home"

end
