class Ability
  include CanCan::Ability

  def initialize(user)
    # Look through all roles the user has
    # Look through all the permissions on every role
    user.roles.each do |role|
      if role.role_name == "Admin"
        can :manage, :all
      else
        role.permissions.each do |permission|
          can permission.action.to_sym, permission.table.classify.constantize
        end
      end   
    end 
    
    # users = [{id: 1, permissions: [["Order", "read".to_sym], ["Product", "read"]]}, {id: 2, permissions: [[:order, :write]]}]

    # users.each do |u|
    #   next if u[:id] != user.id

    #   u[:permissions].each do |p|
    #     can p[1], p[0].constantize, user: user
    #   end
    # end

    # can :write, Order, user: user

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
