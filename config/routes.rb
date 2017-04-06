Rails.application.routes.draw do
  get 'snatch/signup'

  get 'snatch/snatch'

  get 'snatch/about'

  get 'about' => 'snatch#about'
  get 'signup' => 'snatch#signup'

  get '/auth/:provider/callback', to: 'snatch#callback'

  root 'snatch#snatch'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
