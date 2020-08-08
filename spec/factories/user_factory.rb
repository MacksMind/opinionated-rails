# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  active                 :boolean          default(TRUE)
#  address_line_1         :string
#  address_line_2         :string
#  city                   :string
#  company_name           :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country_code           :string(2)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  phone_number           :string
#  postal_code            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles_mask             :integer
#  sign_in_count          :integer          default(0), not null
#  time_zone              :string
#  title                  :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  state_id               :string(4)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    first_name { |user| user.email.present? ? user.email.match(/(.*)@/)[1].titleize : %w[Manny Moe Jack].sample }
    last_name { 'Jones' }
    password { 'testing1' }
    time_zone { 'Eastern Time (US & Canada)' }
    confirmed_at { ::Time.current }
    country_code { 'US' }
    company_name { 'Princeton-Plainsboro Teaching Hospital (PPTH)' }
    address_line_1 do
      num = rand(100..999)
      name = %w[Maple Oak Hickory Apple Ash Beech Cedar Cypress].sample
      suffix = %w[St Ave Rd Dr].sample
      "#{num} #{name} #{suffix}"
    end
    city { %w[Goshen Auburn Bluffton Butler Clinton Columbus Decatur Elkhart Gary Indianapolis Greensburg].sample }
    postal_code { rand(10_000..99_998).to_s }
    state_code { |i| i.country.state_codes.sample }
    phone_number { '123-456-7890' }
  end

  factory :admin_user, parent: :user do
    roles { ['admin'] }
  end
end
