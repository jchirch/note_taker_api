class Subject < ApplicationRecord
  has_many :subject_notes
  has_many :notes, through: :subject_notes

  validates :name, presence: true, uniqueness: true
end
