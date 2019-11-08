require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name 
    self.to_s.downcase.pluralize
  end
  
  def self.column_names
    DB[:conn].results_as_a_hash = true 
    sql = "PRAGMA table_info ('#{table_name}')" #queries table for name of columns
    
    table_info =  DB[:conn].execute(sql)column_names = []
    table_info.each do |col|
      column_names << col["name"]
    end
    column_names.compact
  end
    self.column_names.each do |col_name|
      attr_accessor col_name.to_sym
    end
end