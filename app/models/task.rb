require 'securerandom'  

class Task < ApplicationRecord
  before_create :random_uid
  before_create :format_time

  self.primary_key = :id

  def self.search_by(attr_name, attr_value)
    if (attr_name.present? && attr_value.present?)
      where("#{attr_name} ILIKE ?", "#{attr_value}")
    else
      all
    end
  end

  private
  def random_uid 
    begin
      self.id = SecureRandom.hex(10)
    end while Task.where(id: self.id).exists?
  end

  def format_time 
    self.startDate.to_datetime.strftime('%FT%R')
    self.endDate.to_datetime.strftime('%FT%R')
    self.created_at.strftime('%FT%R')
    self.updated_at.strftime('%FT%R')
  end
end
