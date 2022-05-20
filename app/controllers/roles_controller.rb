class RolesController < ApplicationController
  before_action :get_permissions
  before_action :set_permissions
  before_action :organize_permissions
  load_and_authorize_resource

  # GET /roles or /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1 or /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    @role.role_permissions.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)
    @role.create_permissions(params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to role_url(@role), notice: "Role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    @role.update_permissions(params)
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to role_url(@role), notice: "Role was successfully updated." }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url, notice: "Role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def export_roles
    roles_json = Role.get_roles_permissions.to_json
    send_data roles_json, :type => 'application/json; header=present', :disposition => "attachment; filename=roles.json"
  end

  def import_roles
    roles_json = Role.imp_roles_permissions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def get_permissions
      @get_permissions = Role.get_permissions
      
      @get_permissions.each do |row|
        @get_permissions = Permission.create(table: row[0], action: row[1])
      end
    end

    def set_permissions
      @permissions = Permission.all
    end

    def organize_permissions
      @organized_permissions = Role.organize_permissions
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:role_name, role_permissions_attributes: [:id, :table, :action])
    end
end
