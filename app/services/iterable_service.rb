# frozen string literal
class IterableService

  def create_user_event(name, email)
    events = Iterable::Events.new
    events.track name, email
  end

  def send_notification_for_event_b(name, email)
    create_campaign(name)
    events = Iterable::Events.new
    events.track name, email
    send_notification(campaign_id)
  end

  def create_campaign(name)
    camp = Iterable::Campaigns.new
    camp.create(name, rand(100...10000))
  end

  def send_notification(id)
    templates = Iterable::Push.new
    templates.target campaign_id: id
  end
end