class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :description, :author, :publication_date, :image, :pages, presence: true

  validates_each :status do |record, attr, value|
    record.errors.add(attr, 'currently reading is already taken, add book to future read') if value == "currently_reading"
  end

  mount_uploader :image, BookUploader

  enum status: {
    read: 0,
    currently_reading: 1,
    future_read: 2
  }
end
