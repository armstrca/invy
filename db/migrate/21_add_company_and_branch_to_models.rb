# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/21_add_company_and_branch_to_models.rb
# db/migrate/[timestamp]_add_company_and_branch_to_models.rb
class AddCompanyAndBranchToModels < ActiveRecord::Migration[7.0]
  def change
    add_reference(:users, :company, foreign_key: { to_table: :companies })
    add_reference(:users, :branch, foreign_key: { to_table: :branches })

    add_reference(:products, :company, foreign_key: { to_table: :companies })
    add_reference(:products, :branch, foreign_key: { to_table: :branches })

    add_reference(:orders, :company, foreign_key: { to_table: :companies })
    add_reference(:orders, :branch, foreign_key: { to_table: :branches })

    add_reference(:categories, :company, foreign_key: { to_table: :companies })

    add_reference(:subcategories, :company, foreign_key: { to_table: :companies })

    add_reference(:reports, :company, foreign_key: { to_table: :companies })
    add_reference(:reports, :branch, foreign_key: { to_table: :branches })

    add_reference(:storage_locations, :company, foreign_key: { to_table: :companies })
    add_reference(:storage_locations, :branch, foreign_key: { to_table: :branches })

    add_reference(:suppliers, :company, foreign_key: { to_table: :companies })

    # Add references to other relevant tables

    # Update existing indexes to include company_id and branch_id

    # Example: Update products index
    add_index(
      :products,
      [:company_id, :branch_id, :category_id],
      name: "index_products_on_company_and_branch_and_category",
    )
  end
end
