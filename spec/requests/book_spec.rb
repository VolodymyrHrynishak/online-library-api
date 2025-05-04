require 'swagger_helper'

RSpec.describe "/books", type: :request do
  let(:valid_attributes) {
    { title: 'Title', author: 'Author', description: 'Description' }
  }

  let(:invalid_attributes) {
    { title: nil, author: nil, description: nil }
  }

  path '/api/v1/books' do
    get('list books') do
      tags 'Books'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   author: { type: :string },
                   description: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]
               }

        let!(:book) { Book.create!(valid_attributes) }
        run_test!
      end
    end

    post('create book') do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          book: {
            type: :object,
            properties: {
              title: { type: :string },
              author: { type: :string },
              description: { type: :string }
            },
            required: [ 'title', 'author' ]
          }
        },
        required: [ :book ]
      }

      response(201, 'created') do
        let(:book) { { book: valid_attributes } }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { type: :string },
                 description: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
          expect(response.location).to match(%r{/api/v1/books/\d+})
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:book) { { book: invalid_attributes } }
        run_test!
      end
    end
  end

  path '/api/v1/books/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show book') do
      tags 'Books'
      produces 'application/json'

      response(200, 'successful') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { type: :string },
                 description: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]

        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update book') do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          book: {
            type: :object,
            properties: {
              title: { type: :string },
              author: { type: :string },
              description: { type: :string }
            }
          }
        },
        required: [ :book ]
      }

      response(200, 'successful') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }
        let(:book) { { book: { title: 'New Title' } } }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { type: :string },
                 description: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']).to eq('New Title')
        end
      end

      response(422, 'unprocessable entity') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }
        let(:book) { { book: invalid_attributes } }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:book) { { book: { title: 'New Title' } } }
        run_test!
      end
    end

    put('update book') do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          book: {
            type: :object,
            properties: {
              title: { type: :string },
              author: { type: :string },
              description: { type: :string }
            },
            required: [ 'title', 'author' ]
          }
        },
        required: [ :book ]
      }

      response(200, 'successful') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }
        let(:book) { { book: { title: 'New Title Put', author: 'New Author Put', description: 'New Desc Put' } } }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { type: :string },
                 description: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']).to eq('New Title Put')
          expect(data['author']).to eq('New Author Put')
        end
      end

      response(422, 'unprocessable entity') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }
        let(:book) { { book: invalid_attributes } }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        let(:book) { { book: { title: 'New Title Put', author: 'New Author Put' } } }
        run_test!
      end
    end

    delete('delete book') do
      tags 'Books'

      response(204, 'no content') do
        let!(:existing_book) { Book.create!(valid_attributes) }
        let(:id) { existing_book.id }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
