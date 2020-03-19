class Room < ApplicationRecord
  before_create :set_token

  private

  def set_token
    self.token = DateTime.now.strftime("%Y%m%d%k%M%S%L").to_i.to_s(36)
  end
end
