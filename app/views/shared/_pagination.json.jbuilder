json.pagination do
  json.count @pagy.count
  json.page @pagy.page
  # json.outset @pagy.outset
  json.items @pagy.items
  json.last @pagy.last
  json.pages @pagy.pages
  json.offset @pagy.offset
  # json.params @pagy.params
  json.from @pagy.from
  json.to @pagy.to
  json.in @pagy.in
  json.prev @pagy.prev
  json.next @pagy.next
end
