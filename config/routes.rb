get 'assets', to: 'assets#index'
get 'assets/:id/show', to: 'assets#show'
post 'assets/:id/checkout', to: 'assets#checkout', as: 'checkout_asset'
post 'assets/:id/checkin', to: 'assets#checkin', as: 'checkin_asset'