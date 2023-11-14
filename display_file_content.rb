#/workspaces/Inventory-Management-System/display_file_content.rb
require "clipboard"

def display_file_content(file_path)
  puts "#{file_path}"
  puts "```"
  content = File.read(file_path)
  puts content
  puts "```\n"
end

# Specify the files you want to display
files_to_display = [
  # "/workspaces/Inventory-Management-System/app/views/orders/_order.html.erb",
  # "/workspaces/Inventory-Management-System/app/views/orders/_form.html.erb",
  # "/workspaces/Inventory-Management-System/app/views/orders/show.html.erb",
  # "/workspaces/Inventory-Management-System/app/views/orders/edit.html.erb",
  # "/workspaces/Inventory-Management-System/app/models/order_product.rb",
  # "/workspaces/Inventory-Management-System/app/models/order.rb",
  # "/workspaces/Inventory-Management-System/app/models/product.rb",
  # "/workspaces/Inventory-Management-System/db/schema.rb",
  # "/workspaces/Inventory-Management-System/app/controllers/products_controller.rb",
  # "/workspaces/Inventory-Management-System/app/controllers/orders_controller.rb",
  "/workspaces/Inventory-Management-System/config/routes.rb",
  "/workspaces/Inventory-Management-System/app/policies/application_policy.rb",
  "/workspaces/Inventory-Management-System/app/policies/user_policy.rb",
  "/workspaces/Inventory-Management-System/app/models/user.rb",
  "/workspaces/Inventory-Management-System/app/controllers/users_controller.rb",
  "/workspaces/Inventory-Management-System/app/controllers/application_controller.rb",
  "/workspaces/Inventory-Management-System/app/views/users/_form.html.erb",
  "/workspaces/Inventory-Management-System/app/views/users/new.html.erb",
  "/workspaces/Inventory-Management-System/app/views/users/_admin_form.html.erb",
  "/workspaces/Inventory-Management-System/app/views/users/admin_new.html.erb",
  "/workspaces/Inventory-Management-System/app/views/shared/_flash.html.erb",
  "/workspaces/Inventory-Management-System/app/controllers/custom_devise/registrations_controller.rb",
  "/workspaces/Inventory-Management-System/app/models/concerns/user/roleable.rb",
  # "/workspaces/Inventory-Management-System/config/initializers/devise.rb",
  # "/workspaces/Inventory-Management-System/app/controllers/categories_controller.rb",

]

# Display the content of each file and copy to clipboard
files_to_display.each do |file|
  display_file_content(file)
end
