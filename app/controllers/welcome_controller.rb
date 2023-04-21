class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Jackson Pires [COOKIE]"
    @curso = params[:curso]
    @nome = params[:nome]
  end
end
