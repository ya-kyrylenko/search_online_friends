require 'rspec'
require './page.rb'
require_relative 'page.rb'

describe "test" do
  let(:page) { Page.new('example@example.com', 'password') }
  let(:success_page) { Page.new('email', 'password') }

  describe "Page class" do

    subject { page }

    it { expect(subject).to be_a Page }
    it { should respond_to(:login, :go_to_online_friends, :scroll_down, :display_online_friends, :email, :password) }
    it { expect(subject.email).to eq('example@example.com') }
    it { expect(subject.password).to eq('password') }
  end

  describe 'Failed authorization' do

    subject { page }

    it { expect { subject.login }.to raise_error 'Authorization has been failed'}
  end

  describe 'Success authorization' do

    subject { success_page }

    before { subject.login }

    it { should have_link('log out') }
  end
end