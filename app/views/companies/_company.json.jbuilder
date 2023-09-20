json.extract! company, :id, :name, :created_at, :updated_at, :max_date
json.actions render(partial: 'index_actions', formats: [:html], locals: { cc: company })
json.status Company::STATES[company.status] unless company.status.nil?
json.status 'Own' if company.own == true
json.url company_url(company, format: :json)
json.name render(partial: 'name', formats: [:html], locals: { cc: company })
json.created_at company.created_at.to_date
