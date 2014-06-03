MarketingStandup::Application.routes.draw do
  root 'home#index'
  get 'thanks', to: 'home#thanks', as: 'thanks'
  get 'confirm', to: 'home#confirm'
  get 'confirm/:confirmation_key', to: 'emails#confirm', as: 'confirm_key'
  get 'unsubscribe', to: 'home#unsubscribe'

  resource :emails
end
