require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { should have_many(:subject_notes) }
    it { should have_many(:subjects).through(:subject_notes) }
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end