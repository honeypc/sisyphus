json.columns Tenant.fields.values
json.rows do
  json.array! @records do |tenant|
    json.extract! tenant, :id, :name, :domain
  end
end
json.partial! "shared/pagination"