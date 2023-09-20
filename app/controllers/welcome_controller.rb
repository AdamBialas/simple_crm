class WelcomeController < ApplicationController
  def index
    @dd = params['start_date'].nil? ? Date.current : (Date.parse params['start_date'])
    @cc_list = []
    @cc_list = Plan.companies_in_month(@dd) if LocalRigths.validate(Current.user.rights, 'Plan', 'View')
    params[:company_id] = '' if @cc_list.empty?
  end

  def calendar; end
end
