# /workspaces/Inventory-Management-System/lib/tasks/dev.rake
# unless Rails.env.production?
namespace :dev do
  # Rails.env = "production"
  desc "Drops, creates, migrates, and adds sample data to database"
  task reset: [
        :environment,
        "db:schema:cache:clear",
        "db:drop",
        "db:create",
        "db:migrate",
        "dev:create_users",
        # NITPIK: indents off a bit
        # what's the difference between 1 and 2? 
        "dev:sample_data_1",
        "dev:sample_data_2",
      ]

  desc "Destroy all database data"
  task destroy_all: :environment do
    OrderProduct.destroy_all
    puts "deleted"
    puts OrderProduct.first.inspect
    Product.destroy_all
    puts "deleted"
    Order.destroy_all
    puts "deleted"
    Supplier.destroy_all
    puts "deleted"
    StorageLocation.destroy_all
    puts "deleted"
    Subcategory.destroy_all
    puts "deleted"
    Category.destroy_all
    puts "deleted"
    User.destroy_all
    puts "deleted"
    puts User.first.inspect
    Branch.destroy_all
    puts "deleted"
    puts Branch.first.inspect
    Company.destroy_all
    puts "deleted"
  end
  desc "Create users"
  task create_users: :environment do
    company = Company.create!(id: 1, name: "ZomboCom")
    if company.persisted?
      puts company.inspect
    else
      puts company.errors.full_messages
    end
    branches = 3.times.map { |i| { name: "Branch #{i + 1}", company_id: 1, created_at: Time.current, updated_at: Time.current } }

    # b1 = Branch.create(
    #   id: 1,
    #   name: "Branch 1",
    #   company_id: 1,
    # )

    # b2 = Branch.create(
    #   id: 2,
    #   name: "Branch 2",
    #   company_id: 1,
    # )

    # b3 = Branch.create(
    #   id: 3,
    #   name: "Branch 3",
    #   company_id: 1,
    # )

    Branch.insert_all!(branches)
    if branches.last.present?
      puts branches.last.inspect
    else
      puts branches.errors.full_messages
    end

  end

  desc "Fill the database tables with sample data 1"
  task sample_data_1: :environment do
    company = Company.first
    branch_ids = Branch.pluck(:id)
    roles = %w(admin staff manager)
    statuses = %w(delivered processing in_transit)
    transaction_types = %w(sale_to_customer purchase_from_supplier refund_to_customer return_to_supplier stock_loss)
    u1 = User.create(
      first_name: "Alice",
      last_name: "Smith",
      email: "alice@smith.com",
      password: "password",
      role: "admin",
      bio: Faker::Lorem.paragraph,
      company_id: 1,
      branch_id: Branch.first.id,
    )
    if u1.persisted?
      puts u1.inspect
    else
      puts u1.errors.full_messages
    end
    u2 = User.create(
      first_name: "Staffy",
      last_name: "Staffy",
      email: "staff@staff.staff",
      password: "password",
      role: "staff",
      bio: Faker::Lorem.paragraph,
      company_id: 1,
      branch_id: Branch.first.id,
    )
    if u2.persisted?
      puts u2.inspect
    else
      puts u2.errors.full_messages
    end
    u3 = User.create(
      first_name: "Mangey",
      last_name: "Manager",
      email: "manager@mangey.manga",
      password: "password",
      role: "manager",
      bio: Faker::Lorem.paragraph,
      company_id: 1,
      branch_id: Branch.first.id,
    )
    if u3.persisted?
      puts u3.inspect
    else
      puts u3.errors.full_messages
    end

    users_data = 50.times.map do
      user = User.new(password: "password")
      {
        email: Faker::Internet.unique.email,
        encrypted_password: user.encrypted_password,
        role: roles.sample,
        bio: Faker::Lorem.paragraph,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        company_id: 1,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end

    User.insert_all!(users_data)
    if users_data.last.present?
      puts users_data.last.inspect
    else
      puts users_data.errors.full_messages
    end

    categories_data = 10.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        subcategory: Faker::Commerce.department,
        company_id: 1,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Category.insert_all!(categories_data)

    category_ids = Category.pluck(:id)
    subcategories_data = 20.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        category_id: category_ids.sample,
        company_id: 1,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Subcategory.insert_all!(subcategories_data)

    storage_locations_data = 10.times.map do
      {
        name: Faker::Address.community,
        description: Faker::Lorem.sentence,
        address: Faker::Address.full_address,
        company_id: 1,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    StorageLocation.insert_all!(storage_locations_data)

    suppliers_data = 25.times.map do
      {
        name: Faker::Company.name,
        address: Faker::Address.full_address,
        contact_info: Faker::Internet.email,
        description: Faker::Company.catch_phrase,
        company_id: 1,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Supplier.insert_all!(suppliers_data)

    puts "Sample data 1 has been seeded into the database."
  end

  desc "Fill the database tables with sample data 2"
  task sample_data_2: :environment do
    company = Company.first
    branch_ids = Branch.pluck(:id)
    category_ids = Category.pluck(:id)
    subcategory_ids = Subcategory.pluck(:id)
    storage_location_ids = StorageLocation.pluck(:id)
    addresses = StorageLocation.pluck(:address).sample(10) + 5.times.map { Faker::Address.full_address }
    branch_ids = Branch.pluck(:id)
    roles = %w(admin staff manager)
    statuses = %w(delivered processing in_transit)
    transaction_types = %w(sale_to_customer purchase_from_supplier refund_to_customer return_to_supplier stock_loss)
    orders_data = 500.times.map do
      sending_address = addresses.sample
      receiving_address = addresses.sample

      # Ensure that sending_address and receiving_address are not both StorageLocation.address
      if rand(2).zero?
        sending_address = addresses.sample
        receiving_address = addresses.reject { |addr| addr == sending_address }.sample
      else
        receiving_address = addresses.sample
        sending_address = addresses.reject { |addr| addr == receiving_address }.sample
      end

      {
        expected_delivery: Faker::Date.forward(days: 30),
        status: statuses.sample,
        description: "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}",
        sending_address: sending_address,
        receiving_address: receiving_address,
        company_id: 1,
        branch_id: branch_ids.sample,
        total: 0,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Order.insert_all!(orders_data)

    order_ids = Order.pluck(:id)
    products_data = 300.times.map do
      {
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        sku: Faker::Number.number(digits: 6),
        price: Faker::Commerce.price(range: 10.0..100.0),
        stock_quantity: Faker::Number.between(from: 0, to: 1000),
        category_id: category_ids.sample,
        subcategory_id: Subcategory.pluck(:id).sample,
        supplier_id: Supplier.pluck(:id).sample, # This requires existing Supplier records
        company_id: 1,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Product.insert_all!(products_data)

    product_ids = Product.pluck(:id)
    order_products_data = 3000.times.map do
      {
        quantity_ordered: Faker::Number.between(from: 2, to: 20),
        shipping_cost: Faker::Number.between(from: 1, to: 30),
        order_id: order_ids.sample,
        product_id: product_ids.sample,
        transaction_type: transaction_types.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    OrderProduct.insert_all!(order_products_data)

    #Update orders and product stock quantities
    Order.all.each do |order|
      order.calculate_total
      StockUpdateService.new(order).update_stock!
      order.save!
    end

    puts "Sample data 2 has been seeded into the database."
  end
end
