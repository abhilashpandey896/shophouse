Rails.application.routes.draw do
  
  
  root to: "products#index"
  devise_for :users
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  resources :products do 
    resources :reviews
      collection do
        get :search_user
      end
    end
 
    resources :carts
    post 'carts/:id/add' => "carts#add", as: "cart_add"
    post 'carts/:id/reduce' => "carts#reduce", as: "cart_reduce"
end
   