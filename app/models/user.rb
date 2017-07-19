class User
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  devise :database_authenticatable, :lockable, #:omniauthable,
         :recoverable, :rememberable, :trackable, :encryptable

  field :email,                   type: String
  field :encrypted_password,      type: String
  field :password_salt,           type: String

  field :name,                    type: String

  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time

  field :remember_created_at,     type: Time

  field :sign_in_count,           type: Integer, default: 0
  field :current_sign_in_at,      type: Time
  field :last_sign_in_at,         type: Time
  field :current_sign_in_ip,      type: String
  field :last_sign_in_ip,         type: String

  field :failed_attempts,         type: Integer, default: 0
  field :unlock_token,            type: String
  field :locked_at,               type: Time

  embeds_many :identities

  after_create :default_role

  tmp_email_regex   = /\Achange@me/
  tmp_email_prefix  = 'change@me'
  email_regex       = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  validates :email,         presence: true
  validates :email,         format: {with: email_regex}
  validates :email,         format: {without: tmp_email_regex}, on: :update
  validates :email,         uniqueness: true
  validates :password,      presence: true
  validates :password,      confirmation: true
  validates :password,      length: { in: 6..20 }

  private
    def default_role
      add_role :user
    end

end
