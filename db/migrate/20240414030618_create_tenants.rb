class CreateTenants < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants do |t|
      t.string :classify
      t.string :ancestry, collation: 'C'
      t.string :name
      t.string :domain
      t.jsonb  :metadata

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Tenant.create_translation_table!
      end

      dir.down do
        Tenant.drop_translation_table!
      end
    end
  end
end
