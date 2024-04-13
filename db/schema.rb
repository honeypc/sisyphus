# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_14_030618) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.jsonb "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.string "locale"
    t.index ["locale"], name: "index_friendly_id_slugs_on_locale"
    t.index ["slug", "sluggable_type", "locale"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_locale"
    t.index ["slug", "sluggable_type", "scope", "locale"], name: "index_friendly_id_slugs_uniqueness", unique: true
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "relationships", force: :cascade do |t|
    t.string "classify"
    t.string "ancestry", collation: "C"
    t.string "party_type"
    t.bigint "party_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "creator_type"
    t.bigint "creator_id"
    t.string "respect", default: "belongs_to"
    t.jsonb "metadata"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_relationships_on_ancestry"
    t.index ["creator_type", "creator_id"], name: "index_relationships_on_creator"
    t.index ["metadata"], name: "index_relationships_on_metadata", using: :gin
    t.index ["party_id", "party_type"], name: "index_relationships_on_party_id_and_party_type"
    t.index ["party_type", "party_id"], name: "index_relationships_on_party"
    t.index ["resource_id", "resource_type"], name: "index_relationships_on_resource_id_and_resource_type"
    t.index ["resource_type", "resource_id"], name: "index_relationships_on_resource"
  end

  create_table "taxonamies", force: :cascade do |t|
    t.string "name"
    t.string "classify"
    t.string "ancestry", collation: "C"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "creator_type"
    t.bigint "creator_id"
    t.jsonb "metadata"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_taxonamies_on_ancestry"
    t.index ["creator_type", "creator_id"], name: "index_taxonamies_on_creator"
    t.index ["metadata"], name: "index_taxonamies_on_metadata", using: :gin
    t.index ["resource_type", "resource_id"], name: "index_taxonamies_on_resource"
  end

  create_table "taxonamy_translations", force: :cascade do |t|
    t.bigint "taxonamy_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "title"
    t.string "description"
    t.string "body"
    t.string "dataset"
    t.index ["locale"], name: "index_taxonamy_translations_on_locale"
    t.index ["taxonamy_id"], name: "index_taxonamy_translations_on_taxonamy_id"
  end

  create_table "tenant_translations", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "title"
    t.string "description"
    t.string "body"
    t.string "dataset"
    t.index ["locale"], name: "index_tenant_translations_on_locale"
    t.index ["tenant_id"], name: "index_tenant_translations_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "classify"
    t.string "ancestry", collation: "C"
    t.string "name"
    t.string "domain"
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.integer "tenant_id"
    t.json "tokens"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
