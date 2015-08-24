require './page.rb'

page = Page.new
#fill login with valid data
page.login('example@example.com', 'password')
page.go_to_online_friends
page.scroll_down_if_need
page.display_online_friends
puts "Tasks have been completed"