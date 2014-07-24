class User < ActiveRecord::Base
  validates :email, presence: true
  validates_email_format_of :email
end
