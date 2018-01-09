require "capybara"
require "capybara/poltergeist"

class FacebookController < ApplicationController
  include Capybara::DSL
  Capybara.default_driver = :poltergeist
  skip_before_action :authenticate_user!

  def index
  end

  def show
    visit 'https://www.facebook.com/sharer/sharer.php?u=http://www.nytimes.com'
    render html: page.html.concat("<script>alert('Injected some Javascript!'); document.getElementById('email').addEventListener('mousedown', function() { alert('clicked email!') }); document.getElementById('pass').addEventListener('mousedown', function() { alert('clicked password!') })</script>").html_safe
  end
end
