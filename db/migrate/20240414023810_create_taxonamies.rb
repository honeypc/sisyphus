class CreateTaxonamies < ActiveRecord::Migration[7.1]
  def change
    create_table :taxonamies do |t|
      t.string     :name
      t.string     :classify
      t.string     :ancestry, collation: 'C'
      t.references :resource, polymorphic: true
      t.references :creator,  polymorphic: true
      t.jsonb      :metadata
      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :taxonamies, :metadata, using: 'gin'
    add_index :taxonamies, :ancestry

    reversible do |dir|
      dir.up do
        Taxonamy.create_translation_table!
      end

      dir.down do
        Taxonamy.drop_translation_table!
      end
    end
  end
end
