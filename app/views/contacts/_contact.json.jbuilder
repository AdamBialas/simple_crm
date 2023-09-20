json.extract! contact, :id, :name,:lastname,:email,:phone, :company_id, :jobposition, :created_at, :updated_at
json.url company_contact_url(id: contact.id, format: :json)
json.actions render(partial: "contact_actions", formats: [:html], locals: { cc: contact })
json.email render(partial: "email", formats: [:html], locals: { cc: contact })
json.name_lastname render(partial: "name", formats: [:html], locals: { cc: contact })