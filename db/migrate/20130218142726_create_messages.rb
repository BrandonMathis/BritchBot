class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :groupme_id

      t.timestamps
    end
  end
end
