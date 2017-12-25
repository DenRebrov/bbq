class SubscriptionsController < ApplicationController
  # Задаем «родительский» event для подписки
  before_action :set_event, only: [:create, :destroy]

  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: [:destroy]

  #before_action :email_verification, only: [:create]

  before_action :subscription_verification, only: [:create]

  def create
    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      # Отправляем письмо автору события
      EventMailer.subscription(@event, @new_subscription).deliver_now

      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.subscriptions.destroyed')}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscriptions.error')}
    end

    redirect_to @event, message
  end

  private

  def subscription_verification
    if current_user == @event.user
      redirect_to @event, alert: I18n.t('controllers.subscriptions.subscription_verification_error')
    end
  end

  #def email_verification
  #  if User.find_by(email: subscription_params[:user_email]).present?
  #    redirect_to @event, alert: I18n.t('controllers.subscriptions.email_exist')
  #  end
  #end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end