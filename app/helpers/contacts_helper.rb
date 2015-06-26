module ContactsHelper

  def gravatar_for(contact)
    gravatar_id = Digest::MD5::hexdigest(contact.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: contact.first_name, class: 'gravatar')
  end
end
