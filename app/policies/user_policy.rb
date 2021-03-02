# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.id == user.id
  end

  def destroy?
    record.id == user.id
  end
end
