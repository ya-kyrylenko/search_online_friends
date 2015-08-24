require 'capybara'
require 'capybara/dsl'

class Page

  Capybara.current_driver = :selenium

  include Capybara::DSL

  LOCATOR = '.friends_field>a>b'

  attr_accessor :email, :password

  def initialize(email, password)
    @email    = email
    @password = password
  end

  def login
    visit 'https://vk.com/login'
    fill_in 'email', with: @email
    fill_in 'pass', with: @password
    click_button 'Log in'
    raise "Authorization has been failed" unless has_link?('log out')
    puts "Authorization is successful"
  end

  def go_to_online_friends
    click_link 'My Friends'
    click_link 'Online friends'
  end

  def scroll_down
    count_of_friends_online = find("#friends_summary").text.match(/\d+/)[0].to_i
    count_of_scrooll = (count_of_friends_online + 1)/15
    count_of_scrooll.times {page.driver.browser.find_element(:link, "about").location_once_scrolled_into_view}
  end

  def display_online_friends
    puts "#{all(LOCATOR).count} friend(-s) online"
    all(LOCATOR).each_with_index do |friend, index|
      index += 1
      puts "#{index.to_s}) #{friend.text}"
    end
  end
end