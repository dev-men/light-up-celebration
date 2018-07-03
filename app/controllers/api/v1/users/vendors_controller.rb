class Api::V1::Users::VendorsController < ApplicationController
  def approved_decorators
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.decorators.where(approve: true)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def unapproved_decorators
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.decorators.where(approve: false)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def approved_halls
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.hall_managers.where(approve: true)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def unapproved_halls
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.hall_managers.where(approve: false)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end


  def approved_marquees
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.marquees.where(approve: true)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def unapproved_marquees
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.marquees.where(approve: false)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end


  def approved_photographers
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.photographers.where(approve: true)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def unapproved_photographers
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @vendors = @user.photographers.where(approve: false)
        render json: @vendors.as_json(:except =>[:created_at, :updated_at, :approve, :user_id], :include => [:user]), status: 200
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end
end
