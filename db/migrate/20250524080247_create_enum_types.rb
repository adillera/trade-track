class CreateEnumTypes < ActiveRecord::Migration[8.0]
  def up
    # Drop existing types if they exist
    execute <<-SQL
      DROP TYPE IF EXISTS confidence_level;
      DROP TYPE IF EXISTS trade_result;
      DROP TYPE IF EXISTS position_type;
    SQL

    # Create the enum types
    execute <<-SQL
      CREATE TYPE confidence_level AS ENUM ('high', 'medium', 'low');
    SQL

    execute <<-SQL
      CREATE TYPE trade_result AS ENUM ('win', 'loss', 'break_even');
    SQL

    execute <<-SQL
      CREATE TYPE position_type AS ENUM ('long', 'short');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE IF EXISTS confidence_level;
      DROP TYPE IF EXISTS trade_result;
      DROP TYPE IF EXISTS position_type;
    SQL
  end
end
