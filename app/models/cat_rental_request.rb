class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :overlapping_approved_requests

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id

  def overlapping_requests
    overlapping_requests = []
    all_requests = CatRentalRequest.all
    all_requests.each do |request|
      if (request.start_date..request.end_date).cover?(start_date)
        overlapping_requests << request unless request == self
      elsif (request.start_date..request.end_date).cover?(end_date)
        overlapping_requests << request unless request == self
      end
    end
    overlapping_requests
  end

  def overlapping_approved_requests
    overlapping_requests.each do |request|
      return false if (request.status == "APPROVED" && status == "APPROVED")
    end
    true
  end

  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save!
    end
    # if @cat_rental_request.save
    #   redirect_to cat_rental_requests_url
    # else
    #   @cat_rental_requests.destroy!
    #   render json: @cat_rental_request.errors.full_messages
    # end

  end

end
