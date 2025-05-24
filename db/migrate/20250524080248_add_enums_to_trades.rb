class AddEnumsToTrades < ActiveRecord::Migration[8.0]
  def up
    # First, ensure all existing values are valid
    execute <<-SQL
      UPDATE trades 
      SET confidence = 'high' 
      WHERE confidence NOT IN ('high', 'medium', 'low');
    SQL

    execute <<-SQL
      UPDATE trades 
      SET result = 'win' 
      WHERE result NOT IN ('win', 'loss', 'break_even');
    SQL

    execute <<-SQL
      UPDATE trades 
      SET position = 'long' 
      WHERE position NOT IN ('long', 'short');
    SQL

    # Then add the enums
    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN confidence TYPE confidence_level 
      USING confidence::confidence_level;
    SQL

    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN result TYPE trade_result 
      USING result::trade_result;
    SQL

    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN position TYPE position_type 
      USING position::position_type;
    SQL
  end

  def down
    # Convert back to strings
    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN confidence TYPE varchar 
      USING confidence::varchar;
    SQL

    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN result TYPE varchar 
      USING result::varchar;
    SQL

    execute <<-SQL
      ALTER TABLE trades 
      ALTER COLUMN position TYPE varchar 
      USING position::varchar;
    SQL
  end
end
