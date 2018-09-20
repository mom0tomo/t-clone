class User < ApplicationRecord
  has_many :posts
  has_many :relationships # UserからRelationshipを取得するときはuser_idを使う
  has_many :followings, through: :relationships, source: :follow # リレーションの名前, 中間テーブル, 中間テーブルのカラムの中で参照先とするid
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id' # RelationshipからUserを取得するときはfollow_idを使う
  has_many :followers, through: :reverses_of_relationship, source: :user

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  def follow(other_user)
    self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def timeline_posts
    # following_idsはUserモデルの has_many :followings, ... によって自動的に生成されるメソッド
    Post.where(user_id: [self.id] + self.following_ids)
  end
end