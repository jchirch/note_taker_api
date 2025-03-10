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
      get "/api/v1/notes"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.map { |note| note["title"]}).to include("Make a new Angular app", "Angular dev server")
      expect(json.map { |note| note["content"]}).to include("run in CLI: ng new workspace-name-here", "run in CLI to boot dev server and open app in http://localhost:4200: ng serve --open")
    end
  end

  describe "GET /show" do
    it "returns a single subject" do
      get "/api/v1/notes/#{@note1.id}"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:id]).to eq(@note1.id)
      expect(json[:title]).to eq("Make a new Angular app")
      expect(json[:content]).to eq("run in CLI: ng new workspace-name-here")
    end
  end

  describe "POST /create" do
    it "creates a new note" do
      note_params = { title: "Java Docs", content: "https://docs.oracle.com/en/java/" }
      
      post "/api/v1/notes", params: note_params, as: :json

      expect(response).to have_http_status(201)

      new_note = JSON.parse(response.body, symbolize_names: true)

      expect(new_note[:title]).to eq("Java Docs")
      expect(new_note[:content]).to eq("https://docs.oracle.com/en/java/")
    end
  end
end
