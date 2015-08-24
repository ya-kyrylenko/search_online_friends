require './page.rb'

page = Page.new('example@example.com', 'password')
page.login
page.go_to_online_friends
page.scroll_down
page.display_online_friends
puts "Task finish"