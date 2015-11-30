class Admin::SignedApplicationController < Admin::AdminApplicationController


  def signed_in_user
    unless signed_in?
      store_location
      redirect_to admin_signin_url, notice: 'Please sign in.'
    end
  end

end
