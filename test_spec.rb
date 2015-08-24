require 'rspec'
require './page.rb'

describe "test" do
  subject { Page.new }

  describe "Page class" do
    it { expect(subject).to be_a Page }
    it { should respond_to(:login, :go_to_online_friends, :scroll_down_if_need, :display_online_friends) }
  end

  describe '#login' do
    context 'Failed authorization' do
      it { expect { subject.login('example@example.com', 'password') }.to raise_error 'Authorization has been failed'}
    end

    # to pass this tests fill login with valid data
    context 'Success authorization' do
      it { expect(subject.login('email', 'password')).to eq('Authorization is successful') }

      describe 'Visit online friends' do
        it do
          subject.go_to_online_friends
          should have_title('Friends Online')
        end
      end

      describe 'Uploading online friends' do
        it do
          subject.scroll_down_if_need
          online_friends = subject.find("#friends_summary").text.match(/\d+/)[0].to_i
          uploading_online_friends = subject.all('.friends_field>a>b').count
          expect(online_friends).to eq(uploading_online_friends)
        end
      end
    end
  end
end