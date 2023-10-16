class Plan < ApplicationRecord
  OTHER = 0
  EMAIL = 1
  PHONE = 2
  OFFER = 3
  INVOICE = 4
  CONTRACT = 5

  TYPES = {
    Plan::OTHER => "Other action",
    Plan::EMAIL => "E-mail",
    Plan::PHONE => "Phone",
    Plan::OFFER => "Offer",
    Plan::INVOICE => "Invoice",
    Plan::CONTRACT => "Contract",
  }

  EVENT = 0
  PLANED = 1
  DONE = 2
  CANCELED = 3

  STATUS = {
    Plan::EVENT => "Event",
    Plan::PLANED => "Planed",
    Plan::DONE => "Done",
    Plan::CANCELED => "Canceled",
  }

  belongs_to :company
  validates_presence_of :event_name, :company_id, :event_date, :event_type

  class << self
    def plans_for_day(date, company_id = nil)
      if LocalRigths.validate(Current.user.rights, "Plan", "View")
        if ["", nil, []].include? company_id
          Plan.where("event_date = ?", date).count
        else
          Plan.where("event_date = ? and company_id =? ", date, company_id).count
        end
      else
        0
      end
    end

    def plans_by_params(params)
      if %w[date company].any? { |i| params.keys.include?(i) }
        sql = []

        sql << "event_date='#{params[:date]}' " if params[:date]
        sql << "company_id='#{params[:company]}' " if params[:company]

        Plan.where(sql.join(" and ")).all
      else
        Plan.all
      end
    end

    def companies_in_month(date)
      Plan.select("id,company_id").where("strftime('%m/%Y',event_date)=strftime('%m/%Y','#{date}')").map { |x| x.company_id }
    end
  end
end
