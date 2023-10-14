class Contact < ApplicationRecord
  belongs_to :company
  validates_presence_of :name, :lastname, :status

  def self.contacts_by_params(params)
    where_sql = []
    where_sql << " ((name like '%#{params[:name]}%') or (lastname like '%#{params[:name]}%'))  " unless ["", nil, []].include? params[:name]
    where_sql << "email like '%#{params[:email]}%' " unless ["", nil, []].include? params[:email]
    where_sql << "phone like '%#{params[:phone]}%' " unless ["", nil, []].include? params[:phone]
    Contact.where(where_sql.join(" and ")).order("#{params[:sort] || "name"} #{params[:order] || "DESC"}")
  end
end
