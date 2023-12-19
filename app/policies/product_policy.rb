#/workspaces/Inventory-Management-System/app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
  def create?
    user.admin? || user.manager?
  end

  def show?
    user.staff? || user.admin? || user.manager?
  end

  def index?
    user.staff? || user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def new?
    user.admin?
  end

  def subcategories_by_category?
    user.admin?
  end

  def edit?
    user.admin? || user.manager?
  end

  def destroy?
    !user.manager? || !user.staff?
  end

  # are you using these permitted_attributes methods?
  def permitted_attributes_for_create
    if user.admin? || user.manager?
      # Define permitted attributes for create action
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.admin? || user.manager?
      # Define permitted attributes for update action
    else
      []
    end
  end
end
