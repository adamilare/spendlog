# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?

    can :manage, SpendCategory, user_id: user.id
    can :manage, SpendTransaction, author_id: user.id
  end
end
