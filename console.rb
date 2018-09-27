require_relative("models/movie.rb")
require_relative("models/role.rb")
require_relative("models/actor.rb")
require("pry")

Movie.delete_all
Actor.delete_all
Role.delete_all

movie1 = Movie.new({"title" => "Harry Potter v1", "genre" => "Fantasy", "budget" => "500000000"})
movie2 = Movie.new({"title" => "Usual Suspect", "genre" => "Crime", "budget" => "100000000"})
movie3 = Movie.new({"title" => "Kill Your Darlings", "genre" => "Thriller/Drama", "budget" => "1000"})


movie1.save()
movie2.save()
movie3.save()

# movie2.title  = "Unusual Suspect"
# movie2.update()

actor1 = Actor.new({"first_name" => "Daniel", "last_name" => "Radcliffe"})
actor2 = Actor.new({"first_name" => "Kevin", "last_name" => "Spacey"})
actor3 = Actor.new({"first_name" => "Emma", "last_name" => "Watson"})
actor4 = Actor.new({"first_name" => "Stephen", "last_name" => "Baldwin"})

actor1.save()
actor2.save()
actor3.save()
actor4.save()

# actor1.first_name = "Harry"
# actor1.update()

role1 = Role.new({"movie_id" => movie1.id, "actor_id" => actor1.id, "fee" => "100000"})
role2 = Role.new({"movie_id" => movie2.id, "actor_id" => actor2.id, "fee" => "1000000"})
role3 = Role.new({"movie_id" => movie1.id, "actor_id" => actor3.id, "fee" => "100000"})
role4 = Role.new({"movie_id" => movie2.id, "actor_id" => actor4.id, "fee" => "1000000"})
role5 = Role.new({"movie_id" => movie3.id, "actor_id" => actor1.id, "fee" => "100"})


role1.save()
role2.save()
role3.save()
role4.save()
role5.save()

movies = Movie.all
actors = Actor.all
roles = Role.all

# binding.pry

# p movie1.actors
# p actor1.movies

p movie1.budget

# role1.fee = "5000000"
# role1.update()
