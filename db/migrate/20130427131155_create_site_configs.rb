class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :title
      t.text :description
      t.text :keywords

      t.timestamps
    end
  end
end
