class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  enum role: [:employee, :admin]
  after_initialize :set_default_role_status, :if => :new_record?

  def set_default_role_status
    self.role ||= :employee
    self.status ||= true
  end
  has_many :attendances
end
