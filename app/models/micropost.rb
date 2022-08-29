class Micropost < ApplicationRecord
  belongs_to :user
  delegate :name, to: :user, prefix: true
  has_one_attached :image
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.validate.length_140}
  validates :image, content_type: { in: Settings.micropost.type_allow,
                                    message: :wrong_format },
                    size:         { less_than: Settings.micropost.image_size.megabytes,
                                    message: :too_big }

  scope :by_user_ids, ->(user_ids){where user_id: user_ids}

  def display_image
    image.variant(resize_to_limit: Settings.micropost.resize_to_limit)
  end
end
