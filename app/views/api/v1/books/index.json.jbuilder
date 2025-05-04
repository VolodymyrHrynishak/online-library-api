json.array! @books do |book|
  json.id book.id
  json.title book.title
  json.author book.author
  json.description book.description
end
