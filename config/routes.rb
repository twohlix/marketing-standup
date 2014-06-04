MarketingStandup::Application.routes.draw do
  root    'home#index'
  get     'thanks', to: 'home#thanks', as: 'thanks'
  get     'confirm', to: 'home#confirm', as: 'confirm'
  get     'confirm/:confirmation_key', to: 'emails#confirm', as: 'confirm_key'
  get     'unsubscribe', to: 'home#unsubscribe'

  get     'emails', to: 'emails#index'
  post    'emails', to: 'emails#create', as: 'email'
  get     'emails/new', to: 'emails#new', as: 'new_email'
  get     'emails/:public_id', to: 'emails#show', as: 'show_email'
  get     'emails/:public_id/edit', to: 'emails#edit', as: 'edit_email'
  get     'emails/:public_id/unsubscribe', to: 'emails#unsubscribe', as: 'unsubscribe_email'
  patch   'emails/:public_id', to: 'emails#update'
  put     'emails/:public_id', to: 'emails#update'
  delete  'emails/:public_id', to: 'emails#destroy'

end
