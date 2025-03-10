class NoteSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :subjects
end