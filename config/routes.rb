MarketingStandup::Application.routes.draw do
  root 'home#index'
  get 'thanks', to: 'home#thanks', as: 'thanks'
  get 'confirm/:key', to: 'home#confirm'
  get 'unsubscribe', to: 'home#unsubscribe'

  resource :emails
end
