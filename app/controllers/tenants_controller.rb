class TenantsController < ApplicationController
  def index
    @pagy, @records = pagy policy_scope(Tenant).all
  end
end
