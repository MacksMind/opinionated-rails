# frozen_string_literal: true

module ApplicationHelper
  include LetterAvatar::AvatarHelper

  def gravatar_tag(email, full_name, size: 32, css_class: 'rounded')
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_tag(
      "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=404",
      onerror: "this.onerror=null;this.src='#{avatar_name_path(full_name: full_name, s: size)}';",
      alt: "Gravatar for #{email}",
      class: css_class,
      size: "#{size}x#{size}"
    )
  end
end
