class MixsController < ApplicationController
  def get_gmail
    query_str = params[:q]
    max_num_of_email = params[:email_num] || 5
    emails = MixsHelper::Gmail.new.get_email(query_str,max_num_of_email)
    if emails.empty?
      render :plain=>""
    else
      render :plain=>emails[0][:content][/\d{6}/]
    end
  end
end
