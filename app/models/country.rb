# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  code :string(2)        not null, primary key
#  name :string
#
class Country < ApplicationRecord
  validates :code, :name, uniqueness: { case_sensitive: false }
  validates :code, :name, presence: true

  def state_codes
    State.where(country_code: code).map(&:code)
  end
end
