class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update delete destroy]
  before_action :set_company, only: %i[create new index show edit update delete destroy]

  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  # GET /contacts or /contacts.json
  def index
    if LocalRigths.validate(Current.user.rights, "Contact", "View")
      @pagy, @contacts = pagy @contacts = @company.contacts.all
    else
      redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
    end
  end

  def search
    respond_to do |format|
      format.html do
        if LocalRigths.validate(Current.user.rights, "Contact", "View")
          @pagy, @contacts = pagy Contact.contacts_by_params(params), items: params[:limit]
          @pagy.vars[:params].merge!(params.permit(:name, :email, :phone, :search, :page,
                                                   :authenticity_token).to_h)
          render :all
        else
          redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
        end
      end
      format.json do
        @pagy, @contacts = pagy Contact.contacts_by_params(params), items: params[:limit]
      end
    end
  end

  # GET /contacts/1 or /contacts/1.json
  def show; end

  # GET /contacts/new
  def new
    @contact = @company.contacts.new
  end

  # GET /contacts/1/edit
  def edit; end

  def all
    respond_to do |format|
      format.html do
        if LocalRigths.validate(Current.user.rights, "Contact", "View")
          @pagy, @contacts = pagy Contact.contacts_by_params(params), items: params[:limit]
          @pagy.vars[:params].clear
          render :all
        else
          redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
        end
      end
      format.json do
        @pagy, @contacts = pagy Contact.contacts_by_params(params), items: params[:limit]
      end
    end
  end

  # POST /contacts or /contacts.json
  def create
    @contact = @company.contacts.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html do
          redirect_to request.referrer
          flash[:success] = "Contact was successfully created."
        end
        format.js { redirect_to request.referrer, notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html do
          redirect_to request.referrer
          flash[:success] = "Contact was successfully updated."
        end
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    if LocalRigths.validate(Current.user.rights, "Contact", "Delete")
      @contact.destroy

      respond_to do |format|
        format.html { redirect_to company_contacts_url, notice: "Contact was successfully destroyed." }
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
    @company = Company.find(params[:company_id])
  end

  def set_contact
    set_company
    @contact = @company.contacts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :lastname, :email, :phone, :jobposition, :company_id)
  end
end
