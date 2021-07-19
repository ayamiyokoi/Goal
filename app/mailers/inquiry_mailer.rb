# frozen_string_literal: true

class InquiryMailer < ApplicationMailer
    default from: "example@example.com"   # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => ENV["SEND_MAIL"], :subject => "お問い合わせを承りました")
  end
end
