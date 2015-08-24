require 'capybara'
require 'capybara/dsl'

class Page
  include Capybara::DSL

  Capybara.current_driver = :selenium

  def login(email, password)
    visit 'https://vk.com/login'
    fill_in 'email', with: email
    fill_in 'pass', with: password
    click_button 'Log in'
    raise "Authorization has been failed" unless has_link?('log out')
    puts "Authorization is successful"
  end

  def go_to_online_friends
    click_link 'My Friends'
    click_link 'Online friends'
  end

  def scroll_down_if_need
    count_of_friends_online = find("#friends_summary").text.match(/\d+/)[0].to_i
    count_of_scrooll = (count_of_friends_online + 1)/15
    count_of_scrooll.times {page.driver.browser.find_element(:link, "about").location_once_scrolled_into_view}
  end

  def display_online_friends
    locator = '.friends_field>a>b'
    puts "#{all(locator).count} friend(-s) online"
    all(locator).each_with_index do |friend, index|
      index += 1
      puts "#{index.to_s}) #{friend.text}"
    end
  end
end