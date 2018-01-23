class Comment < ApplicationRecord
  # коммент всегда принадлежит событию и пользователю
  belongs_to :event
  belongs_to :user, optional: true

  # event, body поле должно быть
  validates :event, presence: true
  validates :body, presence: true

  # user_name поле должно быть, только если не выполняется user.present? (у объекта на задан юзер)
  validates :user_name, presence: true, unless: 'user.present?'

  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
end
