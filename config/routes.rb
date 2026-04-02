Rails.application.routes.draw do
  devise_for :admin_users, path: "admin", path_names: {
    sign_in: "login", sign_out: "logout"
  }
  root "pages#home"
  get  "/book",           to: "bookings#new",       as: :new_booking
  post "/book",           to: "bookings#create",    as: :bookings
  get  "/book/success",   to: "bookings#success",   as: :booking_success
  get  "/book/cancelled", to: "bookings#cancelled", as: :booking_cancelled

  namespace :admin do
    root "bookings#index"
    resources :bookings, only: [:index, :show] do
      member { get :calendar }
    end
    get "calendar.ics", to: "bookings#feed", as: :calendar_feed

    # Stripe Connect
    get    "stripe",            to: "stripe#show",              as: :stripe
    post   "stripe/connect",   to: "stripe#connect",           as: :stripe_connect
    get    "stripe/return",    to: "stripe#return_from_stripe", as: :stripe_return
    get    "stripe/refresh",   to: "stripe#refresh",           as: :stripe_refresh
    delete "stripe/disconnect", to: "stripe#disconnect",       as: :stripe_disconnect
  end

  get "sitemap.xml", to: "sitemaps#index", defaults: { format: :xml }
  get "up" => "rails/health#show", as: :rails_health_check
end
