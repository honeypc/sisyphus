class Current < ActiveSupport::CurrentAttributes
  attribute :tenant, :user, :params
end
