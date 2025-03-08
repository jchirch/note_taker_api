require 'rails_helper'

RSpec.describe SubjectNote, type: :model do
  describe 'associations' do
    it { should belong_to(:note) }
    it { should belong_to(:subject) }
  end
end