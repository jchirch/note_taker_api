class SubjectSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :name
  has_many :notes
end
