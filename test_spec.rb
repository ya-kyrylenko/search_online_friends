require 'rspec'
require './page.rb'

describe "test" do
  subject { Page.new}

  describe "Page class" do
    it { expect(subject).to be_a Page }
    it { should respond_to(:login, :go_to_online_friends, :scroll_down, :display_online_friends) }
  end

  describe 'Failed authorization' do
    it { expect { subject.login('example@example.com', 'password') }.to raise_error 'Authorization has been failed'}
  end
  # to pass this test fill login with valid data
  describe 'Success authorization' do
    before { subject.login('email', 'password') }

    it { should have_link('log out') }
  end
end