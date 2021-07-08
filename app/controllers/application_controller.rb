class ApplicationController < ActionController::Base
  protected

  def authenticate
    session[:admin_email] || redirect_to(admins_login_path)
  end

  def delete_empty_folders(this_page)
    empty_sub_folders = Dir.glob('app/assets/images/**/*')

    empty_sub_folders.each do |sub_folder|
      FileUtils.rm_rf(File.expand_path('..', sub_folder)) if Dir.empty?(sub_folder)
    end
  rescue StandardError => e
    puts "DELETION ERROR - #{e.message}"
  ensure
    redirect_to(this_page)
  end
end
