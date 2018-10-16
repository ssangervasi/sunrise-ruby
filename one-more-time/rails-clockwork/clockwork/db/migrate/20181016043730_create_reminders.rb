class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.datetime :alarm_at

      t.timestamps
    end
  end
end
