json.extract! address, :id, :name, :company_id, :country ,:street, :number , :city , :region , :postcode , :status, :main, :created_at, :updated_at
json.url company_address_path(id: address.id,company_id: address.company_id, format: :json)
json.name render(partial: "name", formats: [:html], locals: { ad: address })
json.actions render(partial: "address_actions", formats: [:html], locals: { ad: address })