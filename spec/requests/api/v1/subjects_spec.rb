require 'rails_helper'

RSpec.describe "API::V1::Subjects", type: :request do
  before(:each) do
    @subject1 = FactoryBot.create(:subject, name: "Angular")
    @subject2 = FactoryBot.create(:subject, name: "Golang")
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

  describe "GET /count" do
    it "counts all subjects in database" do
      get "/api/v1/subjects/count"
      expect(response).to have_http_status(:success)
      initial_response = JSON.parse(response.body)

      expect(initial_response).to eq({"count"=>2})

      FactoryBot.create(:subject, name: "PERL")

      get "/api/v1/subjects/count"
      updated_response = JSON.parse(response.body)

      expect(updated_response).to eq({"count"=>3})
    end
  end

  describe "Sad Paths" do
    it "SHOW- returns 404 if subject is not found" do
      get "/api/v1/subjects/999999"
        
      expect(response).to have_http_status(:not_found)
    end

    it "returns an error if name param is missing" do
      subject_params = { name: "" }
      
      post "/api/v1/subjects", params: subject_params, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Name can't be blank")
    end

    it "returns an error if name is not unique" do
      subject_params = { name: "Ruby on Rails" }
      duplicate_subject_params = { name: "Ruby on Rails" }
      
      post "/api/v1/subjects", params: subject_params, as: :json
      post "/api/v1/subjects", params: duplicate_subject_params, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Name has already been taken")
    end
  end
end