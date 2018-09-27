require_relative("../db/sql_runner.rb")

class Role

  attr_accessor :fee
  attr_reader :id, :movie_id, :actor_id

  def initialize(options)
    @id = options["id"].to_i
    @movie_id = options["movie_id"].to_i
    @actor_id = options["actor_id"].to_i
    @fee = options["fee"].to_i
  end


  def save()
    sql = "
    INSERT INTO roles
    (fee,
    movie_id,
    actor_id)
    VALUES($1, $2, $3) RETURNING id
    "
    values = [@fee, @movie_id, @actor_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM roles
    "
    roles = SqlRunner.run(sql)
    result = roles.map { |role| Role.new(role)}
    return result
  end

  def self.delete_all()
    sql = "
    DELETE FROM roles
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE roles
    SET fee = $1
    WHERE id = $2"

    values = [@fee, @id]
    SqlRunner.run(sql, values)
  end

end
