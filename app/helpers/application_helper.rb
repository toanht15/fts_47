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

  def add_fields_answer f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    tmpl = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |b|
      render partial: "#{association.to_s.singularize}_form", locals: {f: b}
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    return "<script> var #{association.to_s}_form = '#{tmpl.to_s}' </script>"
      .html_safe
  end
end
