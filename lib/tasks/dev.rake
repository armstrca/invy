# unless Rails.env.production?
namespace :dev do
  desc "Drops, creates, migrates, and adds sample data to database"
  task reset: [
         :environment,
         "db:schema:cache:clear",
         "db:drop",
         "db:create",
         "db:migrate",
         "dev:sample_data",
       ]

  desc "Fill the database tables with some sample data"
  task sample_data: :environment do
    # if Rails.env.development?

    supplier_company_names = []

    supplier_catchphrases = []

    50.times do
      supplier_company_names << Faker::Company.name
      supplier_catchphrases << Faker::Company.catch_phrase
    end

    company = Company.create(name: "ZomboCom")

    # Create three branches for the company
    3.times do |i|
      b = Branch.create(
        name: "Branch #{i + 1}",
        address: Faker::Address.full_address,
        company_id: company.id,
      )
      if b.persisted?
        puts b.inspect
      else
        puts b.errors.full_messages
      end
    end

    puts "One company with three branches created."

    # Array to store generated email addresses
    generated_emails = []

    200.times do
      # Generate a unique email address
      email = Faker::Internet.unique.email
      while generated_emails.include?(email)
        email = Faker::Internet.unique.email
      end
      generated_emails << email

      User.create(
        email: email,
        password: "password",
        role: %w(admin staff manager).sample,
        bio: Faker::Lorem.paragraph,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        company_id: company.id,
        branch_id: Branch.all.sample.id,
        # image: Faker::Avatar.image,
      )
    end
    puts "200 users created"
    User.create(
      first_name: "Alice",
      last_name: "Smith",
      email: "alice@smith.com",
      password: "password",
      role: "admin",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: Branch.all.sample.id,
    )

    User.create(
      first_name: "Staffy",
      last_name: "Staffy",
      email: "staff@staff.staff",
      password: "password",
      role: "staff",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: Branch.all.sample.id,
    )

    User.create(
      first_name: "Mangey",
      last_name: "Manager",
      email: "manager@mangey.manga",
      password: "password",
      role: "manager",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: Branch.all.sample.id,
    )

    User.create(
      first_name: "Anna",
      last_name: "Knittington",
      email: "anna@cute.girl",
      password: "forever",
      role: "admin",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: 1,
    )

    # Seed Categories table with sample data
    20.times do
      Category.create(
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        subcategory: Faker::Commerce.department,
        company_id: company.id,
      )
    end
    puts "20 categories created"
    40.times do
      Subcategory.create(
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        category: Category.all.sample,
        company_id: company.id,
      )
    end
    puts "40 subcategories created"
    # Seed InventoryTransactions table with sample data
    200.times do
      InventoryTransaction.create(
        transaction_type: %w(incoming_return outgoing_return incoming_sale outgoing_sale).sample,
        quantity: Faker::Number.between(from: 1, to: 100),
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )
    end
    puts "200 inventory_transactions created"
    # Seed Locations table with sample data
    10.times do
      StorageLocation.create(
        name: Faker::Address.community,
        description: Faker::Lorem.sentence,
        address: Faker::Address.full_address,
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )
    end
    puts "10 storage_locations created"
    # Create an array with 10 instances of addresses from Location.address.sample
    location_addresses = StorageLocation.pluck(:address).sample(10)

    # Create an array with 5 instances of addresses generated by Faker
    faker_addresses = 5.times.map { Faker::Address.full_address }

    # Combine the arrays
    addresses = location_addresses + faker_addresses

    # Seed Orders table with sample data
    1000.times do
      sending_address = addresses.sample
      receiving_address = addresses.sample

      # Ensure that at least one of the addresses matches a Location.address
      while !(StorageLocation.exists?(address: sending_address) || StorageLocation.exists?(address: receiving_address))
        sending_address = addresses.sample
        receiving_address = addresses.sample
      end
      o = Order.create(
        expected_delivery: Faker::Date.forward(days: 30),
        status: %w(delivered processing in_transit).sample,
        description: "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}",
        sending_address: sending_address,
        receiving_address: receiving_address,
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )

      # puts o
    end

    puts "1000 orders created"
    # Seed Reports table with sample data (probably not gonna use this but just in case)
    10.times do
      r = Report.create(
        report_type: Faker::Lorem.word,
        date: Faker::Time.backward(days: 90),
        data_criteria: Faker::Lorem.sentence,
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )
    end
    puts "10 reports created"

    50.times do
      s = Supplier.create(
        name: supplier_company_names.uniq.sample,
        address: Faker::Address.full_address,
        contact_info: Faker::Internet.email,
        description: supplier_catchphrases.uniq.sample,
        company_id: company.id,
      )
      if s.persisted?
        puts s.inspect
      else
        puts s.errors.full_messages
      end
    end
    puts "50 suppliers created"
    600.times do
      p = Product.create(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        sku: Faker::Number.number(digits: 6),
        price: Faker::Commerce.price(range: 10.0..100.0),
        stock_quantity: Faker::Number.between(from: 0, to: 1000),
        category_id: Faker::Number.between(from: 1, to: 9),
        subcategory_id: Faker::Number.between(from: 1, to: 24),
        supplier_id: Faker::Number.between(from: 1, to: 9),
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )
      if p.persisted?
        puts p.inspect
      else
        puts p.errors.full_messages
      end
    end
    puts "600 products created"

    # Seed OrderProducts table with sample data
    200.times do
      op = OrderProduct.create(
        quantity_ordered: Faker::Number.between(from: 2, to: 20),
        shipping_cost: Faker::Number.between(from: 1, to: 30),
        order_id: Order.all.sample.id,
        product_id: Product.all.sample.id,
        company_id: company.id,
        branch_id: Branch.all.sample.id,
      )
      # if op.persisted?
      #   puts op.inspect
      # else
      #   puts op.errors.full_messages
      # end
    end
    puts "200 order_products created"

    puts "Sample data has been seeded into the database."
  end
end
# end
# end
