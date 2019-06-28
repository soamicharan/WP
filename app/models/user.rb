class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.create_new_user(email, password)
    user = User.new(:email => email, :password => password )
    user.save
  end
  def self.edit_user(prev_email,new_email,password)
    user=User.find_by_email(prev_email)
    user.update(:email => new_email, :password => password)
    user.save
  end
  def self.delete_user(email)
    user=User.find_by_email(email)
    user.destroy
  end
end
