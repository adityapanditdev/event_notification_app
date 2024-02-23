class EventNotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:create_event, :create_event_with_notification]

  def create_event
    # Logic to create Event A in iterable.com
    if IterableService.new.create_user_event(params[:name], params[:email])
      flash[:success] = 'Event A created!'
    else
      flash[:error] = 'Failed to create Event A'
    end

    redirect_to root_path
  end

  def create_event_with_notification
    # Logic to create Event B in iterable.com
    # After creating Event B, send email notification
    if IterableService.new.send_notification_for_event_b(params[:name], params[:email])
      flash[:success] = 'Event B created and email notification sent!'
    else
      flash[:error] = 'Failed to create Event B or send notification'
    end

    redirect_to root_path
  end
end
