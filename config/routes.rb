Rails.application.routes.draw do
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
  end

  get "sitemap.xml", to: "sitemaps#index", defaults: { format: :xml }
  get "up" => "rails/health#show", as: :rails_health_check
end
