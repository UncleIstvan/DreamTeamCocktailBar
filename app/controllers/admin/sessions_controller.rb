class Admin::SessionsController < Admin::AdminApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      flash[:success] = 'Welcome to Cocktail Bar!'
      redirect_back_or admin_user_path(user)
    else
      # Create and error message and re-render the signin'  form
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to action: :new
  end

  def item_params
   params.require(:sessions).permit(:email, :password)
  end
end
