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
  validates :company_id, presence: true
  validates :event_date, presence: true
  validates :event_type, presence: true

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

        @plans = Plan.where(sql.join(" and ")).all
      else
        @plans = Plan.all
      end
    end

    def companies_in_month(date)
      Plan.select("id,company_id").where("strftime('%m',event_date)=strftime('%m','#{date}')").map { |x| x.company_id }
    end
  end
end
