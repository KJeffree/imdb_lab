require_relative("../db/sql_runner.rb")

class Actor

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def save()
    sql = "
    INSERT INTO actors
    (first_name,
    last_name)
    VALUES($1, $2) RETURNING id
    "
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM actors
    "
    actors = SqlRunner.run(sql)
    result = actors.map { |actor| Actor.new(actor)}
    return result
  end

  def self.delete_all()
    sql = "
    DELETE FROM actors
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE actors
    SET (
    first_name,
    last_name) = ($1, $2)
    WHERE id = $3"

    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def movies()
    sql = "
    SELECT movies.* FROM movies
    INNER JOIN roles
    ON movies.id = roles.movie_id
    WHERE roles.actor_id = $1
    "

    movies = SqlRunner.run(sql, [@id])
    result = movies.map {|movie| Movie.new(movie)}
    return result
  end

end
