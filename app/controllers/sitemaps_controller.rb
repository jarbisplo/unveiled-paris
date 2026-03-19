class SitemapsController < ApplicationController
  def index
    @packages = Package.all
    respond_to do |format|
      format.xml { render layout: false }
    end
  end
end
