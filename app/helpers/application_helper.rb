module ApplicationHelper
  def full_title page_title = ""
    base_title = t "static_pages.title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def gravatar_for user
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = Settings.size
    gravatar_url = Settings.avatar + "{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
