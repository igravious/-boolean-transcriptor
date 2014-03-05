class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def special?
    # not implemented yet :(
    # next in line buddy
    # current_collection.editor? email
    admin == true
  end

  def matches_whodunnit? model
    id == model.versions.last.whodunnit.to_i
  end
end
