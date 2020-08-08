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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :trackable
  belongs_to :country, optional: true, primary_key: :code, foreign_key: :country_code, inverse_of: false
  belongs_to :state, optional: true

  validates \
    :first_name,
    :last_name,
    :time_zone,
    presence: true

  validate :state_code_matches_country

  before_validation :set_time_zone, on: :create

  scope :active, -> { where(active: true) }

  ROLES = %w[admin].freeze
  public_constant :ROLES

  def set_time_zone
    self.time_zone ||= 'Eastern Time (US & Canada)'
  end

  def state_code_matches_country
    return if country_code.blank? && state_id.blank?
    return if country_code.present? && country_code == state_id&.[](0, 2)

    allowed_values = country&.state_codes

    if allowed_values.blank?
      errors.add(:state_id, "not permitted for #{country&.name}") if state_id.present?
    else
      unless allowed_values.include?(state_code)
        errors.add(:state_id, "must be one of #{allowed_values.sort.join(' ')}")
      end
    end
  end

  def roles=(roles)
    self.roles_mask = ((roles || []) & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def role?(role)
    roles.include?(role.to_s)
  end

  scope :with_role, ->(role) { { conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0" } }

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : 'Sorry, this account has been canceled. Please contact support to reactivate.'
  end

  def cancel
    # rubocop:disable Rails/SkipsModelValidations
    # Not concerned about valiations on inactives
    update_attribute(:active, false)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def state_code
    state_id&.[](2, 2)
  end

  def state_code=(code)
    self.state = State.find_by(code: code)
  end
end
