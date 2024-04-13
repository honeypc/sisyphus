class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.string     :classify
      t.string     :ancestry,   collation: 'C'
      t.references :party,      polymorphic: true
      t.references :resource,   polymorphic: true
      t.references :creator,    polymorphic: true
      t.string     :respect,    default: 'belongs_to'
      t.jsonb      :metadata

      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :relationships, :metadata, using: 'gin'
    add_index :relationships, :ancestry
    add_index :relationships, %i[party_id party_type]
    add_index :relationships, %i[resource_id resource_type]
  end
end
