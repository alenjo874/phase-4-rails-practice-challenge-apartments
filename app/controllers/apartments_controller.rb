class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :handle_notfound
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid
    rescue_from ActiveRecord::InvalidForeignKey, with: :handle_foreign_key


    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        show_apartment = Apartment.find_by!(id: params[:id])
        render json: show_apartment
    end

    def create
        create_apartment = Apartment.create!(apartment_params)
        render json: create_apartment
    end

    def update
        update_apartment = Apartment.find_by!(id: params[:id])
        update_apartment.update!(apartment_params)
        render json: update_apartment
    end

    def destroy
        destroy_apt = Apartment.find_by!(id: params[:id])
        destroy_apt.destroy
        render json: {}
    end


    private

    def apartment_params
        params.permit(:number)
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
