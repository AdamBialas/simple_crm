class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy]

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  # GET /companies or /companies.json
  def index
    if LocalRigths.validate(Current.user.rights, "Company", "View")
      @features_list = Company.new.features_list_
      params[:features] = {} if params[:features].nil?
      self.params = params.permit!
      @pagy, @companies = pagy Company.search(params), items: params[:limit]
      @pagy.vars[:params].clear
    else
      redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
    end
  end

  def search
    if LocalRigths.validate(Current.user.rights, "Company", "View")
      @features_list = Company.new.features_list_
      params[:features] = {} if params[:features].nil?
      self.params = params.permit!
      respond_to do |format|
        format.html do
          @pagy, @companies = pagy Company.search(params), items: params[:limit]
          @pagy.vars[:params].merge!(params.permit(:name, :state, :person, :place, :page, :authenticity_token,
                                                   'features': {}).to_h)

          render :index
        end
        format.json do
          @pagy, @companies = pagy Company.search(params), items: params[:limit]
        end
      end
    else
      redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
    end
  end

  # GET /companies/1 or /companies/1.json
  def show
    @main_adress = @company.main_address
    @features_list = @company.features_list_
    params[:features] = if @company.features_hash.nil?
        {}
      else
        JSON.parse @company.features_hash
      end
  end

  # GET /companies/new
  def new
    @company = Company.new
    @features_list = @company.features_list_
    params[:features] = if @company.features_hash.nil?
        {}
      else
        JSON.parse @company.features_hash
      end
  end

  # GET /companies/1/edit
  def edit
    @features_list = @company.features_list_
    params[:features] = if @company.features_hash.nil?
        {}
      else
        JSON.parse @company.features_hash
      end
  end

  # POST /companies or /companies.json
  def create
    params[:company][:features_hash] = params[:features].to_json

    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        format.js { redirect_to company_url(@company), notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        @features_list = @company.features_list_
        format.html { render :new, status: :unprocessable_entity }
        format.js
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def export
    params[:features] = {} if params[:features].nil?
    self.params = params.permit!
    respond_to do |format|
      format.text do
        @companies = Company.search(params)
        headers["Content-Disposition"] = "attachment; filename=\"emaillist_#{Time.now.strftime("%Y%m%d_%H%M%S")}.txt\""
        headers["Content-Type"] ||= "text/plain"
        headers["Transfer-Encoding"] ||= "identity"
        render layout: false
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      params[:company][:features_hash] = params[:features].to_json
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    if LocalRigths.validate(Current.user.rights, "Company", "Delete")
      @company.destroy

      respond_to do |format|
        format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to request.referrer
      flash[:alert] = "You are not permitted to view this page"
    end
  end

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last),
                alert: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :status, :note, :user_id, :features_hash)
  end
end
