json.extract! user, :id, :email, :name, :lastname, :created_at, :updated_at, :rights
json.url users_url(user, format: :json)
json.actions render(partial: 'users_actions', formats: [:html], locals: { user: user })
json.avatar render(partial: 'name', formats: [:html], locals: { user: user })
