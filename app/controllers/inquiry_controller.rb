class InquiryController < ApplicationController

  def index
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      redirect_to inquiry_confirm_path
    else
      redirect_to request.referer
    end
    # redirect_to inquiry_confirm_path(name: params[:inquiry][:name], email: params[:inquiry][:email], message: params[:inquiry][:message])
  end
  

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    # @inquiry = Inquiry.new(name: params[:name], email: params[:email], message: params[:message])

    # 入力値のチェック

    # if @inquiry.valid?
    #   render :action => 'confirm'
    # else
    #   render :action => 'index'
    # end
  end

  # def confirm
  #   # 入力値のチェック
  #   @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
  #   if @inquiry.valid?
  #     redirect_to inquiry_confirm_path
  #   else
  #     render :action => 'index'
  #   end
  # end

  

  def thanks

    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
  end

  private

  # def use_before_action?
  #   false
  # end
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end

end
