Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :airplanes
  resources :seating_sequences do
    member do
      post :populate
    end  
  end 
  # Defines the root path route ("/")
   root "seating_sequences#index"
end
