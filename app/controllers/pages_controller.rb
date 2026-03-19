class PagesController < ApplicationController
  def home
    @packages = Package.all
  end
end
