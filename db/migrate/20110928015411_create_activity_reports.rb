class CreateActivityReports < ActiveRecord::Migration
  def self.up
    create_table :activity_reports do |t|
      t.text :reporte
      t.integer :semana
      t.references :volunteer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :activity_reports
  end
end
