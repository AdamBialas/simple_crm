class Company < ApplicationRecord
  include Rigths
  include Features

  mattr_accessor :features_list

  INACTIVE = 0
  ACTIVE = 1
  HOT = 2
  ORNOT = 3
  NEW = 4
  DETAL = 5
  OTHER = 10

  STATES = {
    Company::INACTIVE => "Inactive",
    Company::ACTIVE => "Active",
    Company::HOT => "Hot",
    Company::ORNOT => "Old",
    Company::NEW => "New",
    Company::DETAL => "Detal",
    Company::OTHER => "Other",
  }
  has_many :contacts, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :plans, dependent: :destroy
  belongs_to :user, default: -> { Current.user }

  scope :id_in_list, ->(ids) { where("id in (?)", ids) }
  scope :order_by_name, -> { order(name: :asc) }

  validates_presence_of :name, :status

  def main_address
    addresses.where("main = true").first
  end

  def email_list
    contacts.select("email").all.map { |x| x.email }
  end

  def self.search(params)
    where_sql = []

    unless params[:features].nil?
      feature_ids = []
      params[:features].each do |key, value|
        Company.connection.select_all("select c.id from companies c ,json_each(features_hash) as x where x.value = '#{value}' and x.key= '#{key}'").each do |feature|
          feature_ids << feature["id"]
        end
      end
    end

    unless ["", nil, []].include? params[:person]
      person_id = Contact.select("company_id").where("name like '%#{params[:person]}%' or lastname like '%#{params[:person]}%' or email like '%#{params[:person]}%' or REPLACE(phone,' ','') like '%#{params[:person]}%' ").all
    end

    unless ["", nil, []].include? params[:place]
      place_id = Address.select("company_id").where("name like '%#{params[:place]}%' or city like '%#{params[:place]}%' or region like '%#{params[:place]}%' or postcode like '%#{params[:place]}%' or country like '%#{params[:place]}%' ").all
    end
    ids = []
    (ids += feature_ids) unless params[:features].empty?
    (ids += person_id.map(&:company_id)) unless ["", nil, []].include? params[:person]
    (ids += place_id.map(&:company_id)) unless ["", nil, []].include? params[:place]
    where_sql << "name like '%#{params[:name]}%' " unless ["", nil, []].include? params[:name]
    where_sql << "status = #{params[:state]} " unless ["", nil, []].include? params[:state]
    where_sql << "id in (#{ids.uniq.join(",")}) " if (!["", nil,
                                                        []].include? params[:person]) || (!["", nil,
                                                                                            []].include? params[:place]) || !params[:features].empty?
    Company.select("companies.*,x.max_date as max_date").joins("left join (select max(event_date) max_date,company_id from plans group by company_id) x on x.company_id=companies.id ").where(where_sql.join(" and ")).order("#{params[:sort] || "name"} #{params[:order] || "DESC"}")
  end

  def self.find_by_id(company_id)
    Company.find(company_id)
  end

  def self.list_for_select
    Company.all.order_by_name
  end

  def self.list_by_ids(ids)
    Company.id_in_list(ids).order_by_name
  end

  def self.clear_main_for_company
    addresses.update_all main_address: false
  end

  def features_list_
    @features_list = []
    @features_list << Features::Feature.new(name: "pricelist", caption: "Price list", type: "select",
                                            values: %w[Common Imported Own])

    @features_list
  end
end
