json.extract! product, :id, :name, :description, :age, :cost, :address, :created_at, :updated_at
json.url product_url(product, format: :json)
