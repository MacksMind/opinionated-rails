# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id           :string(4)        not null, primary key
#  code         :string(2)
#  country_code :string(2)
#  name         :string
#
class State < ApplicationRecord
  validates :code, :name, uniqueness: { within: :country_code, case_sensitive: false }
  validates :code, :name, presence: true
  validates :country_code, inclusion: { in: %w[CA US MX] }
end
