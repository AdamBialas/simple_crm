json.extract! plan, :id, :event_date, :event_name, :event_description, :created_at, :updated_at
json.url plan_url(plan, format: :json)
json.company render(partial: 'company_name', formats: [:html], locals: { cc: Company.find_by_id(plan.company_id) })
json.event_type_s Plan::TYPES[plan.event_type]
json.actions render(partial: 'index_actions', formats: [:html], locals: { plan: plan })
json.status render(partial: 'index_status', formats: [:html], locals: { plan: plan })
if LocalRigths.validate(Current.user.rights, 'Plan', 'Replan')
  json.event_date render(partial: 'index_date', formats: [:html], locals: { plan: plan })
end
json.created_at plan.created_at.to_date
