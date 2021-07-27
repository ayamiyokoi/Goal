# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :session
    # can [:top, :about], :home
    can :manage, :home
    can :manage, Inquiry

    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      # can :manage, :review
      # can :read, :all
      #   if user.product_manager?
      #   can :manage, Stockpile, owner: user # 自分がオーナーの倉庫には全権限を持つ
      #   can :read, Stockpile                 # そうでなくても、読み取り権限を持つ

      #   # 自分の倉庫にある製品に対してすべての権限を持つ
      #   can :manage, Product, stockpile: {owner: user}
      #   # ただし、新規登録、削除はできない
      #   cannot [:create, :destroy], Product
      # end

      # if user.customer?
      #   # 複数のモデルに権限を付与できる
      #   can :read, [Stockpile, Product]

      #   # 独自権限も作れる
      #   can :buy, Procuct, stockpile: nil # 倉庫から出されている製品を買える
      # end
      can :manage, :all

      # can :read, Review, active: true
      # can :manage, :user
      # can :manage, :devise
      # # can :manage, User, id: user.id
      # # #自分が作成したもののみmanage可能
      # can :manage, :goal
      # # can :manage, Goal, user_id: user.id
      # # can :read, Goal
      # can :manage, :task
      # # can :manage, Task, user_id: user.id
      # can :manage, :chat
      # # can :manage, Chat, user_id: user.id
      # # can :read, Chat
      # can :manage, :group
      # # can :manage, Group
      # can :manage, :comment
      # # can :manage, Comment, user_id: user.id
      # # can :read, Comment
      # can :manage, :like
      # # can :manage, Like, user_id: user.id
      # # can :read, Like
      # can :manage, :event
      # # can :manage, Event, user_id: user.id
      # can :manage, :follow
      # # can :manage, Follow
      # can :manage, :friend
      # # can :manage, Friend
      # can :manage, Notification
      # 他者が作成した振り返りは公開中のみ、閲覧可能

    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
