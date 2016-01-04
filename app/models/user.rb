require 'bcrypt'
enable :sessions

class User < ActiveRecord::Base
	validates_format_of :email,:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

# As is the 'standard' with rails apps we'll return the user record if the
    # password is correct and nil if it isn't.
    def self.authenticate(email, password)
      # Because we use bcrypt we can't do this query in one part, first
      # we need to fetch the potential user
      if user = find_by_email(email)
        # Then compare the provided password against the hashed one in the db.
        if BCrypt::Password.new(user.encrypted_password).is_password? password
          # If they match we return the user 
          return user
        end
      end
      # If we get here it means either there's no user with that email, or the wrong
      # password was provided.  But we don't want to let an attacker know which. 
      return nil
    end



    # give_token
end