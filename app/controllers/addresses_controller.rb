class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  before_action :set_company, only: %i[create new index show edit update delete destroy]

  before_action :validate_view_rigths, only: %i[index search all show]
  before_action :validate_delete_rigths, only: %i[destroy]
  before_action :validate_new_rigths, only: %i[new]
  before_action :validate_edit_rigths, only: %i[edit]

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  # GET /addresses or /addresses.json
  def index
    @pagy, @addresses = pagy @addresses = @company.addresses
  end

  # GET /addresses/1 or /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = @company.addresses.new
  end

  # GET /addresses/1/edit
  def edit; end

  # POST /addresses or /addresses.json
  def create
    @address = @company.addresses.new(address_params)
    @company.clear_main_for_company if params[:main_address] == true
    respond_to do |format|
      if @address.save
        format.html do
          redirect_to request.referrer
          flash[:success] = "Address was successfully created."
        end
        format.js { redirect_to request.referrer, notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    @company.clear_main_for_company if params[:main_address] == true
    respond_to do |format|
      if @address.update(address_params)
        format.html do
          redirect_to request.referrer
          flash[:success] = "Address was successfully updated."
        end
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html do
        redirect_to request.referrer
        flash[:success] = "Address was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  def search
    respond_to do |format|
      format.html do
        @pagy, @addresses = pagy Address.search(params), items: params[:limit]
        @pagy.vars[:params].merge!(params.permit(:name, :street, :city, :postcode, :search, :page,
                                                 :authenticity_token).to_h)
        render :all
      end
      format.json do
        @pagy, @addresses = pagy Address.search(params), items: params[:limit]
      end
    end
  end

  def all
    respond_to do |format|
      format.html do
        @pagy, @addresses = pagy Address.search(params), items: params[:limit]
        @pagy.vars[:params].clear
        render :all
      end
      format.json do
        @pagy, @addresses = pagy Address.search(params), items: params[:limit]
      end
    end
  end

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last),
                alert: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_address
    set_company
    @address = Address.find(params[:id])
  end

  def validate_view_rigths
    return if LocalRigths.validate(Current.user.rights, "Address", "View")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  def validate_delete_rigths
    return if LocalRigths.validate(Current.user.rights, "Address", "Delete")
    redirect_to(request.referrer, alert: "You are not permitted to view this page")
  end

  def validate_edit_rigths
    return if LocalRigths.validate(Current.user.rights, "Address", "Edit")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  def validate_new_rigths
    return if LocalRigths.validate(Current.user.rights, "Address", "New")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:name, :company_id, :country, :street, :number, :city, :region, :main, :postcode)
  end
end
