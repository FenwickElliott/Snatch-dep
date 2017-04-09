Rails.application.routes.draw do
  get 'snatch/signup'
  get 'snatch/snatch'
  get 'snatch/about'
  get 'snatch/fail'
  get 'snatch/options'

  get 'about' => 'snatch#about'
  get 'signup' => 'snatch#signup'
  get 'options' => 'snatch#options'

  get '/auth/:provider/callback', to: 'snatch#callback'
  get '/auth/failure' , to: 'snatch#fail'

  root 'snatch#snatch'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
