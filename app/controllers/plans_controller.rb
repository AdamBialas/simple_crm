class PlansController < ApplicationController
  before_action :set_plan, only: %i[show edit update destroy set_status set_date]
  before_action :set_cache_headers

  before_action :validate_view_rigths, only: %i[index search show]
  before_action :validate_delete_rigths, only: %i[destroy]
  before_action :validate_new_rigths, only: %i[new new_on_date new_for_company]
  before_action :validate_edit_rigths, only: %i[edit]

  # GET /plans or /plans.json
  def index
    @plans = Plan.plans_by_params(params)
  end

  def search
    @plans = Plan.plans_by_params(params)
    render "index"
  end

  # GET /plans/1 or /plans/1.json
  def show; end

  # GET /plans/new
  def new
    @plan = Plan.new
    if params[:date]
      @plan.event_date = params[:date]
    else
      @plan.event_date = DateTime.now.to_date
      params[:date] = DateTime.now.to_date
    end
    @plan.company_id = params[:company] if params[:company]
  end

  def new_on_date
    @plan = Plan.new
    @plan.event_date = params[:date]
    render :new_on_date
  end

  def new_for_company
    @plan = Plan.new
    params[:date] = DateTime.now.to_date
    @plan.company_id = params[:company_id]
    render :new_for_company
  end

  # GET /plans/1/edit
  def edit; end

  # POST /plans or /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html do
          redirect_to request.referrer
          flash[:success] = "Task was successfully created."
        end
        format.js { redirect_to request.referrer, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html do
          redirect_to request.referrer
          flash[:success] = "Task was successfully updated."
        end
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy

    respond_to do |format|
      format.html do
        redirect_to request.referrer
        flash[:success] = "Task was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  def set_status
    @plan.status = params[:plan][:status]
    @plan.save!
  end

  def set_date
    unless params[:plan][:event_date].empty?
      @plan.event_date = params[:plan][:event_date]
      @plan.save!
    end
    redirect_to request.referrer
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end

  def validate_view_rigths
    return if LocalRigths.validate(Current.user.rights, "Plan", "View")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  def validate_delete_rigths
    return if LocalRigths.validate(Current.user.rights, "Plan", "Delete")
    redirect_to(request.referrer, alert: "You are not permitted to view this page")
  end

  def validate_edit_rigths
    return if LocalRigths.validate(Current.user.rights, "Plan", "Edit")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  def validate_new_rigths
    return if LocalRigths.validate(Current.user.rights, "Plan", "New")
    redirect_to(main_app.root_path, alert: "You are not permitted to view this page")
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def plan_params
    params.require(:plan).permit(:event_date, :event_name, :event_description, :status, :event_type, :company_id,
                                 :contact_id, :address_id, :user)
  end
end
