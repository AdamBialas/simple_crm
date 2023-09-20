class Contact < ApplicationRecord
  belongs_to :company


def self.search(params)
  where_sql = []
  where_sql << " ((name like '%#{params[:name]}%') or (lastname like '%#{params[:name]}%'))  " unless ["",nil,[]].include? params[:name]
  where_sql << "email like '%#{params[:email]}%' " unless ["",nil,[]].include? params[:email]
  where_sql << "phone like '%#{params[:phone]}%' " unless ["",nil,[]].include? params[:phone]
  Contact.where(where_sql.join(" and ")).order("#{params[:sort]||'name'} #{params[:order]||'DESC'}")
end  

end