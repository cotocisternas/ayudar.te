class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = UsersPaginator.new(self).users
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def create
    @user = User.new(user_attributes)

    if @user.save
      json_response(@user, :created, true)
    else
      json_error(@user)
    end
  end

  def update
    if @user.valid_password?(user_attributes[:password])
      if @user.update(user_attributes)
        head :no_content
      else
        json_error(@user)
      end
    else
      custom_json_error('password', 'invalid password')
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
    def user_attributes
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
