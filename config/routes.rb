# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
  scope '/ntust_asset_manager' do
    resources :assets, only: [:create, :update, :index, :show], defaults: { format: 'json' }
    match '/assets/*path', to: 'assets#options', via: :options
  end
end
