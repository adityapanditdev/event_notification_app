require 'rails_helper'

RSpec.describe IterableService do
  let(:iterable_events_double) { instance_double(Iterable::Events) }
  let(:iterable_campaigns_double) { instance_double(Iterable::Campaigns) }
  let(:iterable_push_double) { instance_double(Iterable::Push) }
  let(:campaign_id) { 123 }

  before do
    allow(Iterable::Events).to receive(:new).and_return(iterable_events_double)
    allow(Iterable::Campaigns).to receive(:new).and_return(iterable_campaigns_double)
    allow(Iterable::Push).to receive(:new).and_return(iterable_push_double)
    allow(iterable_campaigns_double).to receive(:create).and_return(campaign_id)
  end

  describe '#create_user_event' do
    it 'tracks user event' do
      name = 'test_name'
      email = 'test@example.com'

      expect(iterable_events_double).to receive(:track).with(name, email)

      subject.create_user_event(name, email)
    end
  end

  describe '#send_notification_for_event_b' do
    it 'creates a campaign and sends notification' do
      name = 'test_name'
      email = 'test@example.com'

      expect(iterable_campaigns_double).to receive(:create).with(name, instance_of(Integer))
      expect(iterable_events_double).to receive(:track).with(name, email)
      expect(iterable_push_double).to receive(:target).with(campaign_id: campaign_id)

      subject.send_notification_for_event_b(name, email)
    end
  end
end
