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

  def status_str
    status.to_s
  end

  def set_status(status)
    if 'can_help' == status.downcase
      can_help!
      update(status_expires_at: Time.now.utc + 1.hours)
    elsif 'need_help' == status.downcase
      need_help!
      update(status_expires_at: Time.now.utc + 1.hours)
    elsif 'work_in_progress' == status.downcase
      work_in_progress!
      update(status_expires_at: nil)
    else
      false
    end
  end

  def check_expired_status
    puts Time.now.utc
    puts status_expires_at
    if status_expires_at && (status_expires_at < Time.now.utc)
      set_status('work_in_progress')
      true
    else
      false
    end
  end

  def create_discord_verify_token
    @discord_verify_token = SecureRandom.base64(10)
    update(discord_verify_digest: BCrypt::Password.create(@discord_verify_token))
    @discord_verify_token
  end
end
