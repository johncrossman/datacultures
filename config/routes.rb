Rails.application.routes.draw do

  root :to => 'bootstrap#index'
  post '/canvas/embedded/*url'           => 'canvas_lti#embedded', defaults: { format: 'html' }
  get '/canvas/lti_engagement_index'     => 'canvas_lti#lti_engagement_index', defaults: { format: 'xml' }
  get '/canvas/lti_points_configuration' => 'canvas_lti#lti_points_configuration', defaults: { format: 'xml'}
  get '/canvas/lti_gallery'              => 'canvas_lti#lti_gallery', defaults: { format: 'xml'}
  get '/download/activities'             => 'activities#index'

  namespace :api do
    namespace :v1 do
      get '/user_info/me'            => 'user_info#show', defaults: { format: 'json'}
      get '/assignments'             => 'assignments#index', defaults: {format: 'json'}
      get '/engagement_index/data'   => 'engagement_index#index', defaults: { format: 'json'}
      post '/students/:canvas_id'    => 'students#update'
      get '/students/:canvas_id'     => 'students#show'
      get '/gallery/index' => 'gallery#index', defaults: { format: 'json'}
      get '/gallery/:gallery_id'     => 'gallery#show'
      resources :points_configuration, only: [:index, :update]
      resources :comments, only: [ :create]
      put  '/comments'               => 'comments#update'
      resources :likes, only: [:create]
      resources :workers, only: [:create]
      post '/views'                  => 'views#increment'
    end
  end

  get '/*url' => 'bootstrap#index', defaults: { format: 'html' }
end
