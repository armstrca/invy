# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/policies/product_policy.rb
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


end
