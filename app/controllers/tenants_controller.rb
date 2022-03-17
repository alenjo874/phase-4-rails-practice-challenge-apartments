class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :handle_notfound
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid
    rescue_from ActiveRecord::InvalidForeignKey, with: :handle_foreign_key


    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        show_tenant = Tenant.find_by!(id: params[:id])
        render json: show_tenant
    end

    def create
        create_tenant = Tenant.create!(tenant_params)
        render json: create_tenant
    end

    def update
        update_tenant = Tenant.find_by!(id: params[:id])
        update_tenant.update!(tenant_params)
        render json: update_tenant
    end

    def destroy
        destroy_tenant = Tenant.find_by!(id: params[:id])
        destroy_tenant.destroy
        render json: {}
    end


    private

    def tenant_params
        params.permit(:name, :age)
    end

    def handle_invalid(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def handle_notfound
        render json: {errors: "not found"}, status: :not_found
    end

    def handle_foreign_key
        render json: {errors: "cannot be deleted because a parent record references it"}, status: :internal_server_error
    end

end
