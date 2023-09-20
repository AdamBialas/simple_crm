json.extract! address, :id, :name, :company_id, :country, :street, :number, :city, :region, :postcode, :status,
              :main, :created_at, :updated_at
json.url company_address_path(id: address.id, company_id: address.company_id, format: :json)
json.name render(partial: 'all_name', formats: [:html], locals: { ad: address, company_id: address.company_id })
json.actions render(partial: 'all_address_actions', formats: [:html],
                    locals: { ad: address, company_id: address.company_id })
json.company render(partial: 'company_name', formats: [:html], locals: { cc: address.company })
