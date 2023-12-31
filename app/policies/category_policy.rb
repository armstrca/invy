# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/policies/category_policy.rb
class CategoryPolicy < ApplicationPolicy
  def create?
    user.admin? || user.manager?
  end

  def show?
    user.admin? || user.manager? || user.staff?
  end

  def update?
    user.admin? || user.manager?
  end

  def edit?
    user.admin? || user.manager?
  end

  def new?
    user.admin? || user.manager?
  end

  def destroy?
    !(user.admin? || user.manager?) # Admins and managers can delete categories
  end

end
