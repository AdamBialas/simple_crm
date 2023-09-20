json.extract! contact, :id, :name, :lastname, :email, :phone, :company_id, :jobposition, :created_at, :updated_at
json.url company_contact_url(id: contact.id,company_id: contact.company_id, format: :json)
json.name_lastname render(partial: 'all_name', formats: [:html], locals: { ct: contact, company_id: contact.company_id })
json.actions render(partial: 'all_contact_actions', formats: [:html],
                    locals: { ct: contact, company_id: contact.company_id })
json.company render(partial: 'company_name', formats: [:html], locals: { cc: contact.company })
json.email render(partial: "email", formats: [:html], locals: { cc: contact })