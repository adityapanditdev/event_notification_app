require 'rails_helper'

RSpec.describe EventNotificationsController, type: :controller do

  let(:user) { User.create(email: 'test@123', password: '12345678')}

  before do
    sign_in user
  end

  describe "#create_event" do
    it "creates Event A and redirects to root path" do
      allow_any_instance_of(IterableService).to receive(:create_user_event).and_return(true)

      post :create_event, params: { name: "Event A", email: "test@example.com" }

      expect(flash[:success]).to eq('Event A created!')
      expect(response).to redirect_to(root_path)
    end

    it "handles event creation failure gracefully" do
      allow_any_instance_of(IterableService).to receive(:create_user_event).and_return(false)  # Stubbing the event creation to return false indicating failure

      post :create_event

      expect(flash[:error]).to eq('Failed to create Event A')
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#create_event_with_notification" do
    it "Creates Event B and sends email notification before redirecting" do
      iterable_service = double('iterable_service')
      allow(IterableService).to receive(:new).and_return(iterable_service)
      allow(iterable_service).to receive(:send_notification_for_event_b).and_return(true)

      post :create_event_with_notification, params: { name: "Event B", email: "test@example.com" }

      expect(flash[:success]).to eq('Event B created and email notification sent!')
      expect(response).to redirect_to(root_path)
    end

    it "handles notification sending failure gracefully" do
      iterable_service = double('iterable_service')
      allow(IterableService).to receive(:new).and_return(iterable_service)
      allow(iterable_service).to receive(:send_notification_for_event_b).and_return(false)  # Stubbing the notification sending to return false indicating failure

      post :create_event_with_notification

      expect(flash[:error]).to eq('Failed to create Event B or send notification')
      expect(response).to redirect_to(root_path)
    end
  end
end
