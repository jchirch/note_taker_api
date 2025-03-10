require 'rails_helper'

RSpec.describe "API::V1::Subjects", type: :request do
  before(:each) do
    @subject1 = Subject.create!(name: "Angular")
    @subject2 = Subject.create!(name: "Golang")
  end

  describe "GET /index" do
    it "returns all subjects" do
      get "/subjects"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.map { |subject| subject["name"] }).to include("Angular", "Golang")
    end
  end

  describe "GET /show" do
    it "returns a single subject" do
      get "/subjects/#{@subject1.id}"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@subject1.id)
      expect(json["name"]).to eq("Angular")
    end
  end

  describe "POST /create" do
    it "creates a new subject" do
      subject_params = { subject: { name: "Java" } }

      expect {
        post "/subjects", params: subject_params
      }.to change(Subject, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq("Java")
    end
  end
end
