json.array!(@documents) do |document|
  json.extract! document, :id, :code, :origin, :type, :ubication
  json.url document_url(document, format: :json)
end
