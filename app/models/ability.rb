class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
        can :manage, :all
    elsif user.manager?
        can :manage, :file_uploader
        can :manage, Page
        can :manage, PageCategory
        can :manage, BlogCategory
        can :manage, BlogPost
        can :access, :ckeditor
        can [:read, :create, :destroy], Ckeditor::Picture
        can [:read, :create, :destroy], Ckeditor::AttachmentFile
    elsif user.blogger?
        can :manage, BlogPost
        can :access, :ckeditor
        can [:read, :create, :destroy], Ckeditor::Picture
        can [:read, :create, :destroy], Ckeditor::AttachmentFile
    end
  end
end
