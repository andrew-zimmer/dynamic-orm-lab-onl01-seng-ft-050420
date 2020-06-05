require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name 
    self.to_s.downcase.pluralize
  end 
  
  def self.column_names 
    DB[:conn].results_as_hash = true 
    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each {|column| column_names << column["name"]}
    column_names.compact
  end 
  
  def initialize(options={})
    options.each {|property, value| self.instance_variable_set("@#{property}", value)}
  end 
  
  def table_name_for_insert
    self.class.table_name
  end 
  
  
end