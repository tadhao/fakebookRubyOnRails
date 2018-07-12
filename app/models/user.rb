class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_many :friendships
  has_many :received_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

   def friends
    friends_array = friendships.map{|friend| friend.friend_id if friend.accepted}
    friends_array =friends_array + received_friendships.map{|friend| friend.user_id if friend.accepted}
    friends_array.compact
  end

  # Users who have yet to confirme friend requests< aane wali request
  def pending_friends
    friendships.map{|friend| friend.friend_id if !friend.accepted}.compact

  end

  # Users who have requested to be friends> jane wali request
  def friend_requests
    received_friendships.map{|friend| friend.user_id if !friend.accepted}.compact
  
	end

	def confirm_friend(user)
    friendship = received_friendships.find{|friend| friend.user_id = user}
    friendship.accepted = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
 	

	# has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
	# has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
 # 	has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
 # 	has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

# # to call all your friends

# 	def friends
#  	  active_friends | received_friends
#  	end

# # # to call your pending sent or received

#  	def pending
#  		pending_friends | requested_friendships
#  	end
end