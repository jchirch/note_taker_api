# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

angular = Subject.create!(name: "Angular")
golang = Subject.create!(name: "Golang")

note1 = Note.create!(title: "Make a new Angular app", content: "run in CLI: ng new workspace-name-here")
note2 = Note.create!(title: "Angular dev server", content: "run in CLI to boot dev server and open app in http://localhost:4200: ng serve --open")
note3 = Note.create!(title: "What is Golang?", content: "An open sourced language by Google, it's statically typed, has a fast startup time, and low runtime overhead.")

angular.notes << note1
angular.notes << note2
golang.notes << note3

puts "Database successfully seeded."