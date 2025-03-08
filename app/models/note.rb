class Note < ApplicationRecord
  has_many :subject_notes
  has_many :subjects, through: :subject_notes

  validates :title, presence: true
  validates :content, presence: true
end
