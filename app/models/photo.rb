class Photo < ApplicationRecord
  # Фотография оставлена к какому-то событию
  belongs_to :event

  # Фотографию добавил какой-то пользователь
  belongs_to :user, optional: true

  # У фотографии всегда есть событие и пользователь
  validates :event, presence: true
  validates :user, presence: true

  # Добавляем аплоадер фотографий, чтобы заработал carrierwave
  mount_uploader :photo, PhotoUploader

  # scope нужен чтобы отделить реальные фотки от болванки
  scope :persisted, -> { where "id IS NOT NULL" }
end
