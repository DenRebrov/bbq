# Контроллер вложенного ресурса комментариев
class CommentsController < ApplicationController
  # задаем "родительский" event для коммента
  before_action :set_event, only: [:create, :destroy]

  # задаем сам коммент
  before_action :set_comment, only: [:destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      # уведомляем всех подписчиков о новом комментарии
      notify_subscribers(@event, @new_comment)

      # если сохранился успешно, редирект на страницу самого события
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      # если ошибки — рендерим здесь же шаблон события
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.comments.destroyed')}

    # удалять комментарии может только пользователь, который их создал
    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: I18n.t('controllers.comments.error')}
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    # собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    user_subscriber = event.subscribers.find_by(params[:user_email])

    # автор комментария не получает уведомления на почту о своем собственном комменте и
    # если зарегистрированный пользователь оставляет комментарий в событие, на которое подписан,
    # то тоже не получает уведомления об этом, в остальных же случаях уведомления получают все
    if current_user == event.user || user_subscriber.present?
      all_emails = (event.subscriptions.map(&:user_email)).uniq
    else
      all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    end

    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now
    end
  end
end