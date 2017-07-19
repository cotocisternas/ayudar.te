class User
  module Omniauth
    extend ActiveSupport::Concern

    # def self.find_for_oauth(auth, signed_in_resource = nil)
    #   user = signed_in_resource ? signed_in_resource : where("identities.uid" => auth.uid, "identities.provider" => auth.provider).first
    #
    #   if user.nil?
    #     email_is_verified = auth.info.email || auth.info.verified || auth.info.verified_email
    #     email = auth.info.email if email_is_verified
    #     user  = User.find_by(email: email) if email
    #
    #     if user.nil?
    #       user = User.new(
    #         name: auth.info.name,
    #         email: email ? email : "#{tmp_email_prefix}-#{auth.uid}-#{auth.provider}.com",
    #         password: Devise.friendly_token[0,20],
    #       )
    #       user.identities.push(Identity.new(uid: auth.uid, provider: auth.provider))
    #       user.save!
    #     else
    #       user.identities.push(Identity.new(uid: auth.uid, provider: auth.provider))
    #       user.name = auth.info.name,
    #       user.save!
    #     end
    #   end
    #
    #   if user.identities.find_by(provider: auth.provider)
    #     user
    #   else
    #     user.identities.push(Identity.new(uid: auth.uid, provider: auth.provider))
    #     user
    #   end
    # end
    #
    # def email_verified?
    #   self.email && self.email !~ tmp_email_regex
    # end

  end
end
