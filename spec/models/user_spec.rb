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
require 'rails_helper'

describe User do
  it 'creates a new instance given valid attributes' do
    user = FactoryBot.build(:user)
    user.save!
  end

  it 'cancels account' do
    user = FactoryBot.create(:user)
    user.cancel
    expect(user.active).to be(false)
  end

  it 'sets country code and read name' do
    user = FactoryBot.create(:user)
    expect(user.country_code).to eq 'US'
    expect(user.country.name).to eq 'UNITED STATES'
    user.update!(state_id: nil, country_code: 'ZA')
    expect(user.country_code).to eq 'ZA'
    expect(user.country.name).to eq 'SOUTH AFRICA'
  end

  it 'sets state code and read name' do
    user = FactoryBot.create(:user)
    user.update!(state_code: 'CA')
    expect(user.state_code).to eq 'CA'
    expect(user.state.name).to eq 'California'
  end

  it 'allows missing country and state' do
    expect { FactoryBot.create(:user, country_code: nil, state_code: nil) }.not_to raise_error
  end

  it 'allows country without state' do
    expect { FactoryBot.create(:user, country_code: 'ZA') }.not_to raise_error
  end

  it 'allows country with state' do
    expect { FactoryBot.create(:user, country_code: 'US', state_code: 'IN') }.not_to raise_error
  end

  it 'denys stateless country with state' do
    expect { FactoryBot.create(:user, country_code: 'ZA', state_code: 'IN') }
      .to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'denys stateful country with missing state' do
    expect { FactoryBot.create(:user, country_code: 'US', state_code: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'denys stateful country with wrong state' do
    expect { FactoryBot.create(:user, country_code: 'CA', state_code: 'IN') }
      .to raise_error(ActiveRecord::RecordInvalid)
  end
end
