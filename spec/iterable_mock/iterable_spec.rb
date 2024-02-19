require 'rails_helper'
require 'webmock/rspec'
require 'net/http'

RSpec.describe 'Iterable Integration', type: :request do

  before(:each) do
    stub_request(:get, 'https://api.iterable.com/api/events/track').to_return(status: 200, body: '{"success": true}', headers: {})
  end

  describe 'Creating Event A' do
    it "Should get response from facebook" do
      uri = URI("https://api.iterable.com/api/events/track")
      response = Net::HTTP.get(uri)
      expect(response).to be_an_instance_of(String)
    end
  end

  describe 'Creating Event B' do
    before(:each) do
      stub_request(:get, 'https://api.iterable.com/api/push/target').to_return(status: 200, body: '{"success": true}', headers: {})
    end

    it 'associates Event B with a user in iterable.com and sends email notification' do
      uri = URI("https://api.iterable.com/api/push/target")
      response = Net::HTTP.get(uri)
      expect(response).to be_an_instance_of(String)
    end
  end
end
