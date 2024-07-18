require 'securerandom'  

class Task < ApplicationRecord

  before_create :random_uid
  before_create :format_time
  belongs_to :category, optional: true

  self.primary_key = :id

  def self.search_by(attr_name, attr_value)
    where("#{attr_name} =?", "#{attr_value}")
  end

  def self.date_between(check_date)
    where("startDate <= ? AND ? <= endDate", check_date, check_date)
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
