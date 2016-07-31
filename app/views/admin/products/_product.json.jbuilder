json.extract! product, :id, :name, :type, :length, :width, :height, :weight, :slug, :created_at, :updated_at
json.url admin_product_url(product, format: :json)