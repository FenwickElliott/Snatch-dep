Rails.application.routes.draw do
  get 'snatch/signup'

  get 'snatch/snatch'

  get 'snatch/about'

  root 'snatch#snatch'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
