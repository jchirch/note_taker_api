# Note Taker API

## Description
This is the API for a notetaker app to allow me to learn new technologies and document as I go. It is a boilerplate API used to create and update note cards for various subjects.

## Initialization
Clone into local directory, open in code editor, run `bundle install` & `rails s`

## Requests
**Get All Notes**

Endpoint: GET /api/v1/notes

Response: Returns an array of all notes.

**Show A Note**

Endpoint: GET /api/v1/notes/:id

Response: Returns a note by id.

**Post New Note**

Endpoint: POST /api/v1/notes

Body:
```
{
    "title": "Postman Note take 2",
    "content": "Postman is great when it works, which is a rarity"
}
```

Response: Returns the created note with an ID.

**Get All Subjects**  

**Endpoint:** `GET /api/v1/subjects`  

**Response:** Returns an array of all subjects.  

**Show A Subject**

Endpoint: GET /api/v1/subjects/:id

Response: Returns a subject by id.

**Post New Subject**

Endpoint: POST /api/v1/subjects

Body:
```
{
    "name": "Markdown"
}
```

**Count all Subjects**

Endpoint: GET /api/v1/subjects/count

Response: Returns an object: {count: #}

**Count all Notes**

Endpoint: GET /api/v1/notes/count

Response: Returns an object: {count: #}

## Testing
RSpec was used for all test suites.
- For associations and validations run: `bundle exec rspec spec/models`
- For request testing run: `bundle exec rspec spec/requests`

## Tech Used
* Ruby version: ruby 3.2.2
* RSpec version: RSpec 3.13
  - rspec-core 3.13.3
  - rspec-expectations 3.13.3
  - rspec-mocks 3.13.2
  - rspec-rails 7.1.1
  - rspec-support 3.13.2
* FactoryBot-Rails
* ShouldaMatchers 6.0