class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :discord_id, uniqueness: true, allow_nil: true

  # See https://www.sitepoint.com/enumerated-types-with-activerecord-and-postgresql/
  enum status: %i[work_in_progress need_help can_help]

  def discord?
    !discord_id.nil?
  end

  def name
    if discord?
      discord_username
    else
      email.to_s
    end
  end
end
