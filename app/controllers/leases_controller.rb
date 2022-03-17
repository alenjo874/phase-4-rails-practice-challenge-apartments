class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :handle_notfound
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid

    def create
        create_lease = Lease.create!(lease_params)
        render json: create_lease
    end
    def destroy
        destroy_lease = Lease.find_by!(id: params[:id])
        destroy_lease.destroy
        render json: {}
    end


    private

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end


    def handle_invalid(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def handle_notfound
        render json: {errors: "not found"}, status: :not_found
    end
end
