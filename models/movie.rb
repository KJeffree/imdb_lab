require_relative("../db/sql_runner.rb")

class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @title = options["title"]
    @genre = options["genre"]
    @budget = options["budget"].to_i
  end


  def save()
    sql = "
    INSERT INTO movies
    (title,
    genre,
    budget)
    VALUES($1, $2, $3) RETURNING id
    "
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM movies
    "
    movies = SqlRunner.run(sql)
    result = movies.map { |movie| Movie.new(movie)}
    return result
  end

  def self.delete_all()
    sql = "
    DELETE FROM movies
    "
    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE movies
    SET (
    title,
    genre,
    budget) = ($1, $2, $3)
    WHERE id = $4"

    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def actors()
    sql = "
    SELECT actors.* FROM actors
    INNER JOIN roles
    ON actors.id = roles.actor_id
    WHERE roles.movie_id = $1
    "

    actors = SqlRunner.run(sql, [@id])
    result = actors.map {|actor| Actor.new(actor)}
    return result
  end

  def budget()
    sql = "
    SELECT roles.fee FROM roles
    INNER JOIN movies
    ON movies.id = roles.movie_id
    WHERE roles.movie_id = $1
    "

    roles = SqlRunner.run(sql, [@id])
    result = roles.map {|role| role["fee"].to_i}

    for expense in result
      @budget -= expense
    end
    return @budget
  end
=begin


  #array of role in movies
  get the total fee of all roles
  bugget -= total fees

=end


end
