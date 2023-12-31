# /workspaces/Inventory-Management-System/app/policies/application_policy.rb
# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user?
    user == record
  end

  def index?
    false
  end

  def password?
    true
  end

  def forgot_password?
    true unless user.present?
  end

  def incoming?
    false
  end

  def outgoing?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
