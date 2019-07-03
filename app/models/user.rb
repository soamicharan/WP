# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

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
