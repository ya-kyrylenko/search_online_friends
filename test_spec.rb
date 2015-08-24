require 'rspec'
require './page.rb'

describe "page class" do
  subject { Page.new }

  it { expect(subject).to be_a Page }
  it { expect(subject).to respond_to(:login, :go_to_online_friends, :scroll_down_if_need, :display_online_friends) }

  describe '#login' do
    context 'failed authorization' do
      it { expect { subject.login('example@example.com', 'password') }.to raise_error 'Authorization has been failed'}
    end

    # to pass this tests fill login with valid data
    context 'success authorization' do
      it { expect(subject.login('email', 'password')).to eq('Authorization is successful') }

      describe '#go_to_online_friends' do
        before { subject.go_to_online_friends }

        it { should have_title('Friends Online') }
      end

      describe 'loading online friends' do
        before { subject.scroll_down_if_need }
        it 'must show all friends online' do
          count_online_friends = subject.find("#friends_summary").text.match(/\d+/)[0].to_i
          count_visible_online_friends = subject.all('.friends_field>a>b').count
          expect(count_online_friends).to eq(count_visible_online_friends)
        end
      end

      describe '#display_online_friends' do
        it 'should have correct names' do
          subject.all('.friends_field>a>b').each do |friend|
            expect(friend.text).to match(/[A-Z]{1}[a-z']+\s{1}[A-Z]{1}[a-z']+/)
          end
        end
      end
    end
  end
end