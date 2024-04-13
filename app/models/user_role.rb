class UserRole < Relationship
  belongs_to :user, class_name: 'User', foreign_key: :party_id
  belongs_to :role, class_name: 'Role', foreign_key: :resource_id
end
