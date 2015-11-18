
class CatRentalRequestsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to new_cat_rental_request_url
    else
      render :new
      p @cat_rental_request.errors.full_messages
    end
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
  end

  def approve!
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.transaction do
      status = "APPROVED"
      save
    end
    # if @cat_rental_request.save
    #   redirect_to cat_rental_requests_url
    # else
    #   @cat_rental_requests.destroy!
    #   render json: @cat_rental_request.errors.full_messages
    # end

  end

  private
  def cat_rental_request_params
    params
      .require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :status)
  end
end
