class AddLocaleToFriendlyIdSlugs < ActiveRecord::Migration[7.1]
  def change
    add_column :friendly_id_slugs, :locale, :string, null: :false

    remove_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :locale]
    remove_index :friendly_id_slugs, [:slug, :sluggable_type, :scope]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope, :locale], unique: true, name: :index_friendly_id_slugs_uniqueness
    add_index :friendly_id_slugs, :locale
  end
end
