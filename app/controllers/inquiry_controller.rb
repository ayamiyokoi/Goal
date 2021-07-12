class InquiryController < ApplicationController

  def index
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    # binding.irb
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
    # redirect_to inquiry_confirm_path(name: params[:inquiry][:name], email: params[:inquiry][:email], message: params[:inquiry][:message])
  end


  def thanks

    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
    render :action => 'thanks'
  end

  private

  def use_before_action?
    false
  end

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end

end
