require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    where_input = params.map { |pair| "#{pair.first} = ?" }.join(" AND ")
    attr_values = params.map { |pair| "#{pair.last}" }
    
    instance_params = DBConnection.execute(<<-SQL, *attr_values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_input}
    SQL

    instance_params.map { |param| self.new(param)}

  end
end

class SQLObject
  extend Searchable
end
