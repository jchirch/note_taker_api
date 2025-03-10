class NoteSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :content
  has_many :subjects
end