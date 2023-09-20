class Address < ApplicationRecord
  belongs_to :company


def self.search(params)
  where_sql = []
  where_sql << "name like '%#{params[:name]}%' " unless ["",nil,[]].include? params[:name]
  where_sql << "city like '%#{params[:city]}%' " unless ["",nil,[]].include? params[:city]
  where_sql << "street like '%#{params[:street]}%' " unless ["",nil,[]].include? params[:street]
  where_sql << "postcode like '%#{params[:postcode]}%' " unless ["",nil,[]].include? params[:postcode]
 Address.where(where_sql.join(" and ")).order("#{params[:sort]||'name'} #{params[:order]||'DESC'}")
end  

end
