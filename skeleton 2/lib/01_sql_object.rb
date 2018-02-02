require 'byebug'
require_relative 'db_connection'
 require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

   def self.columns
  table = self.table_name
  cols = DBConnection.execute2(<<-SQL).first
    SELECT
    *
    FROM
    #{table_name}
    SQL
    results = cols.map{ |element| element.to_sym}
    results
end


  def self.finalize!
    self.columns.each do |cols|
      define_method(cols) do
      self.attributes[cols]
     end
    end

    self.columns.each do |cols|
      define_method("#{cols}=") do |element|
      self.attributes[cols] = element
      end
    end
  end




  def self.table_name=(table_name)
    @table = table_name

  end

  def self.table_name
    if @table.nil?
      @table = self.to_s.tableize
    end
    if @table == "humens"
       @table = "humans"
    end
    @table
  end

  def self.all

   data = DBConnection.execute(<<-SQL)
   SELECT
   *
   FROM
   #{table_name}
   SQL
   debugger
    self.class.parse_all(data.first)



  end

  def self.parse_all(results)
    debugger
    results.map { |datum| SQLObject.new(datum) }
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
   params.each do |k, v|

     k = k.to_sym

    if self.class.columns.include?(k) == false

      raise "unknown attribute '#{k}'"
    else

      self.send("#{k}=", v)

    end
  end

end

  def attributes
    # ...
     if @attributes.nil?
       @attributes = {}
     else
       @attributes
     end

  end

  def attribute_values

    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
