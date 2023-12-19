#/workspaces/Inventory-Management-System/app/policies/registrations_controller_policy.rb
#/workspaces/Inventory-Management-System/app/policies/user_policy.rb
class RegistrationsControllerPolicy < ApplicationPolicy
  def show?
    user.admin? || user.manager? || user.staff?
  end

  def create?
    user.admin? || (user.manager? && !record.admin?)
  end

  def new?
    user.admin? || (user.manager? && !record.admin? && !record.staff?)
  end

  def admin_new?
    user.admin? || (user.manager? && !record.admin?)
  end

  def update?
    # huh?
    # seems like this could be `user.admin? || user.manager?`
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end

  def destroy?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end

  def edit_role?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end

  def permitted_attributes_for_create
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :role, :bio, :image] - [:role]
    else
      []
    end
  end

  def permitted_attributes_for_new
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :role, :bio, :image] - [:role]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :bio, :image] - [:role]
    else
      []
    end
  end
end
