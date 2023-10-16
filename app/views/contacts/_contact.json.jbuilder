json.extract! contact, :id, :name, :lastname, :phone, :company_id, :created_at, :updated_at
json.url company_contact_url(id: contact.id, format: :json)
json.actions render(partial: "contact_actions", formats: [:html], locals: { cc: contact })
json.email render(partial: "email", formats: [:html], locals: { cc: contact })
json.name_lastname render(partial: "name", formats: [:html], locals: { cc: contact })
json.jobposition contact.jobposition.present? ? contact.jobposition : "[empty]"
json.email contact.email.present? ? contact.email : "[empty]"
json.phone contact.phone.present? ? contact.phone : "[empty]"
