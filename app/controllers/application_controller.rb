# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  include Pagy::Backend
  include Pagy::Frontend
  set_current_tenant_through_filter

  before_action :set_current_tenant_by_request

  def set_current_tenant_by_request
    Current.tenant = Tenant.where(domain: request.base_url).first_or_create!
    set_current_tenant(Current.tenant)
  end
end
