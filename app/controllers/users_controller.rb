class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy], except: %i[new index]
  before_action :set_cache_headers

  # GET /users or /users.json
  def index
    respond_to do |format|
      format.html do
        @pagy, @users = pagy User.all, items: params[:limit]
      end
      format.json do
        @pagy, @users = pagy User.all, items: params[:limit]
      end
    end
  end

  def search
    respond_to do |format|
      format.html do
        @pagy, @users = pagy User.all, items: params[:limit]
        render :index
      end
      format.json do
        @pagy, @users = pagy User.all, items: params[:limit]
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    unless @user.rights.nil?
      rols = @user.rights.split(',')
      rols.each do |role|
        params[role.to_s] = 1
      end
    end
  end

  # POST /users or /users.json
  def create
    rols = params.select { |key, _value| key.to_s.include?('role_') }
    rols = rols.to_enum.to_h.map { |string, _value| string }
    params[:user][:rights] = rols.join(',')
    params[:user][:password_confirmation] = params[:user][:password]

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          redirect_to users_path
          flash[:success] = 'User was successfully created.'
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    rols = params.select { |key, _value| key.to_s.include?('role_') }
    rols = rols.to_enum.to_h.map { |string, _value| string }
    params[:user][:rights] = rols.join(',')
    if params[:user][:password].empty?
      respond_to do |format|
        if @user.update_without_password(user_params)
          format.html do
            redirect_to request.referrer
            flash[:success] = 'User was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    else
      params[:user][:password_confirmation] = params[:user][:password]
      respond_to do |format|
        if @user.update(user_params)
          format.html do
            redirect_to request.referrer
            flash[:success] = 'User was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Mon, 01 Jan 1990 00:00:00 GMT'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :name, :lastname, :rights, :password_confirmation, :password)
  end
end
