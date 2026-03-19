module Admin
  class BaseController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "paris2026"
  end
end
