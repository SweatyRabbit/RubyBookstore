# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    address_form = AddressForm.new(addresses_params)
    if address_form.save(current_user)
      flash[:success] = t('addresses.form.success', type: addresses_params[:address_type])
    else
      flash[:danger] = address_form.errors.full_messages.to_sentence
    end

    redirect_to edit_user_registration_path
  end

  def addresses_params
    params.require(:address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone,
                                    :address_type).merge(user: current_user)
  end
end
