get 'assets', to: 'assets#index'
post 'assets/:id/checkout', to: 'assets#checkout', as: 'checkout_asset'
post 'assets/:id/checkin', to: 'assets#checkin', as: 'checkin_asset'