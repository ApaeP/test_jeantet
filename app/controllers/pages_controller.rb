class PagesController < ApplicationController
  def home
    @main_form = MainForm.new
  end
end
