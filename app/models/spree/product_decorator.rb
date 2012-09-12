Spree::Product.class_eval do
  before_update :create_redirect
  def create_redirect
    return true unless name_changed?
    save_permalink(self.name)
    return true unless permalink_changed?
    redirect = Spree::Redirect.find_or_initialize_by_old_url("/products/#{self.permalink_was}")
    redirect.new_url = "/products/#{self.permalink}"
    redirect.save
  end 
end
