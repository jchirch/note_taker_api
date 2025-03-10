require 'rails_helper'

RSpec.describe "API::V1::Subjects", type: :request do
  before(:each) do
    @subject1 = Subject.create!(name: "Angular")
    @subject2 = Subject.create!(name: "Golang")
  end

  describe "GET /index" do
    it "returns all subjects" do
      get "/api/v1/subjects"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.map { |subject| subject["name"] }).to include("Angular", "Golang")
    end
  end

  describe "GET /show" do
    it "returns a single subject" do
      get "/api/v1/subjects/#{@subject1.id}"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:id]).to eq(@subject1.id)
      expect(json[:name]).to eq("Angular")
    end
  end

  describe "POST /create" do
    it "creates a new subject" do
      subject_params =  { name: "Java" } 

      post "/api/v1/subjects", params: subject_params, as: :json

      expect(response).to have_http_status(201)
      new_sub = JSON.parse(response.body, symbolize_names: true)
      expect(new_sub[:name]).to eq("Java")
    end
  end
end
