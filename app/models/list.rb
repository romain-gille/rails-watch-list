class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  validates :name, presence: true, uniqueness: true
  has_one_attached :photo

#   validate :at_least_one_img

# def at_least_one_img
#   if [self.picture_url, self.en_name].reject(&:blank?).size == 0
#     if self.photo.
#     errors[:base] << ("Please choose at least one name - any language will do.")
#   end
# end

  # validates :picture_url, format: { with: /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/i }, allow_blank: true

end
