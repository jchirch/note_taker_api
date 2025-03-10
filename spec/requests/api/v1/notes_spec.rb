require 'rails_helper'

RSpec.describe "API::V1::Notes", type: :request do
  before(:each) do
    @subject1 = Subject.create!(name: "Angular")
    @subject2 = Subject.create!(name: "Golang")
    @note1 = Note.create!(title: "Make a new Angular app", content: "run in CLI: ng new workspace-name-here")
    @note2 = Note.create!(title: "Angular dev server", content: "run in CLI to boot dev server and open app in http://localhost:4200: ng serve --open")

    SubjectNote.create!(subject: @subject1, note: @note1)
    SubjectNote.create!(subject: @subject2, note: @note2)
    end

  describe "GET /index" do
    it "returns all notes" do
      get "/notes"

    
    end
  end

  describe "GET /show" do
    it "returns a single subject" do
      get "/notes/#{@note1.id}"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@note1.id)
      expect(json["title"]).to eq("Make a new Angular app")
      expect(json["content"]).to eq("run in CLI: ng new workspace-name-here")
    end
  end

  describe "POST /create" do
    it "creates a new subject" do
      # subject_params = { subject: { name: "Java" } }
      subject_params = { name: "Java" }

      
      post "/api/v1/notes", params: subject_params, as: :json
      

      # expect(response).to have_http_status(:created)

      new_subject = JSON.parse(response.body)
      puts 'new subject <><><><>'
      puts new_subject
      expect(json["name"]).to eq("Java")
    end
  end
end
