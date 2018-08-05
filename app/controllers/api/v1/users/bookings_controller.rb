class Api::V1::Users::BookingsController < ApplicationController

  def index
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        if @user.role == 1
          @bookings = @user.bookings.order('created_at DESC')
          render :json => {:bookings => @bookings.as_json(
                            except: [:created_at, :updated_at, :user_id, :imageable_id],
                            include: {
                                        imageable: {
                                            except: [:created_at, :updated_at, :user_id, :id, :approve, :image2, :image3],
                                            include: { user: { except: [:created_at, :id, :email, :updated_at, :authentication_token, :cnic, :role, :vendor_role] } }
                                        }
                                    }
                          )}, status: 200
        else
          @bookings = []
          @vendor = nil
          @halls = @user.hall_managers
          @photographers = @user.photographers
          @decorators = @user.decorators
          @marquees = @user.marquees
          if @halls
            @halls.each do |h|
              if h.bookings
                @b = h.bookings.order('created_at DESC')
                @b.each do |bb|
                  @bookings << bb
                end
              end
            end
          end
          if @photographers
            @photographers.each do |h|
              if h.bookings
                @b = h.bookings.order('created_at DESC')
                @b.each do |bb|
                  @bookings << bb
                end
              end
            end
          end
          if @marquees
            @marquees.each do |h|
              if h.bookings
                @b = h.bookings.order('created_at DESC')
                @b.each do |bb|
                  @bookings << bb
                end
              end
            end
          end
          if @decorators
            @decorators.each do |h|
              if h.bookings
                @b = h.bookings.order('created_at DESC')
                @b.each do |bb|
                  @bookings << bb
                end
              end
            end
          end
          render json: @bookings.as_json(except: [:id, :created_at, :updated_at, :user_id, :imageable_id],
                                          include: {
                                            user: { except: [:authentication_token, :id, :email, :created_at, :updated_at, :role, :vendor_role, :cnic] },
                                            imageable: { except: [:created_at, :updated_at, :id, :image2, :image3, :user_id, :approve] }
                                          }
                                        ), status: 200
        end
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def create
    begin
      @user = User.find_by_email(params[:user_email])
      if @user.role == 1
        @imageable_id = params[:imageable_id].to_i
        @imageable_type = params[:imageable_type]
        @day = params[:day]
        @start = params[:start]
        @end = params[:end]
        @location = params[:location]
        @b = Booking.where("imageable_id = ? AND imageable_type = ? AND day = ?", @imageable_id, @imageable_type, @day)
        if @b.count > 0
          @errors = "Sorry, No booking available for " + @day + ".\nPlease select another date."
          render json: {:errors => @errors}, status: 200
        else
          @b = Booking.new
          @b.user_id = @user.id
          @b.imageable_id = @imageable_id
          @b.imageable_type = @imageable_type
          @b.day = @day
          @b.start = @start
          @b.end = @end
          @b.location = @location
          if @b.save
            render json: @b.as_json(:except =>[:created_at, :updated_at, :user_id]), status: 200
          else
            render json: {:errors => @b.errors.full_messages}, status: 200
          end
        end

      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  def update
    begin
      @user = User.find_by_email(params[:user_email])
      if @user.role == 1
        @b = Booking.find(params[:id])
        @b.day = params[:day]
        @b.start = params[:start]
        @b.end = params[:end]
        @b.location = params[:location]
        if @b.save
          render json: @b.as_json(:except =>[:created_at, :updated_at, :user_id]), status: 200
        else
          render json: {:errors => @b.errors.full_messages}, status: 200
        end
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end
end
