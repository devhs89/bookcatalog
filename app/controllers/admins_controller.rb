class AdminsController < ApplicationController
  def login
    # Setting a session variable after admin login
    @admin_email = Admin.find_by(email: params[:email])

    if @admin_email&.authenticate(params[:password])
      session[:admin_email] = @admin_email
      redirect_to(books_path)
    else
      render('login')
    end
  end
end
