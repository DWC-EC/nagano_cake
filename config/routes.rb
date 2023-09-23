Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do#urlからpublicを取る
    root to: 'homes#top'
    get "about" => "homes#about"
    get "customers/show" => "customers#show"
    get "/customers/information/edit" => "customers#edit"
    patch "/customers/information" => "customers#update"
    get "/customers/confirm_withdraw" => "customers#confirm_withdraw"
    patch "/customers/withdraw" => "customers#withdraw"
  end

  namespace :admin do#namespaceでurlにadminをつける
    get "" => "homes#top"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
