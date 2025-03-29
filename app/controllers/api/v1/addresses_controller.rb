module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_address, only: [:update, :destroy]

      def index
        addresses = current_user.addresses
        render json: {
          status: 'success',
          data: {
            addresses: addresses.map { |address| format_address(address) }
          }
        }
      end

      def create
        address = current_user.addresses.build(address_params)
        
        if address.save
          render json: {
            status: 'success',
            message: 'Address created successfully',
            data: {
              address: format_address(address)
            }
          }, status: :created
        else
          render json: {
            status: 'error',
            message: 'Address creation failed',
            errors: address.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @address.update(address_params)
          render json: {
            status: 'success',
            message: 'Address updated successfully',
            data: {
              address: format_address(@address)
            }
          }
        else
          render json: {
            status: 'error',
            message: 'Address update failed',
            errors: @address.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        if @address.destroy
          render json: {
            status: 'success',
            message: 'Address deleted successfully'
          }
        else
          render json: {
            status: 'error',
            message: 'Address deletion failed',
            errors: @address.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def set_address
        @address = current_user.addresses.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          status: 'error',
          message: 'Address not found'
        }, status: :not_found
      end

      def address_params
        params.require(:address).permit(
          :street,
          :city,
          :state,
          :postal_code,
          :country,
          :building_or_estate_name,
          :house_number_or_name
        )
      end

      def format_address(address)
        {
          id: address.id,
          street: address.street,
          city: address.city,
          state: address.state,
          postal_code: address.postal_code,
          country: address.country,
          building_or_estate_name: address.building_or_estate_name,
          house_number_or_name: address.house_number_or_name,
          created_at: address.created_at,
          updated_at: address.updated_at
        }
      end
    end
  end
end
