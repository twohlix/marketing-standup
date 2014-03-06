MarketingStandup::Application.routes.draw do
  root 'home#index'
  get 'confirm/:key', to: 'home#confirm'
  get 'unsubscribe', to: 'home#unsubscribe'
end
