# frozen_string_literal: true

class InquiryController < ApplicationController
  before_action :set_inquiry, only: %i(confirm thanks)

  def index
    @inquiry = Inquiry.new
  end

  def confirm
    if @inquiry.valid?
      render :action => "confirm"
    else
      render :action => "index"
    end
  end

  def thanks
    InquiryMailer.received_email(@inquiry).deliver
    render :action => "thanks"
  end

  private

  def use_before_action?
    false
  end

  def set_inquiry
    @inquiry = Inquiry.new(inquiry_params)
  end

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
