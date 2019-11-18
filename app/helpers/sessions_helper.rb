# frozen_string_literal: true

module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  # This code for current_user the Ruby idiom to the following (more readable, and that's in the book):
  # if session[:user_id]
  #  @current_user ||= User.find_by(id: session[:user_id])
  # end
  def current_user
    return @current_user ||= User.find_by(id: session[:user_id]) unless !session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
