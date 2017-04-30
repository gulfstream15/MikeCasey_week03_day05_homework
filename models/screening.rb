require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :time1, :time2, :time3

  # , :time2, :time3

  def initialize( options )
    @id = options['id'].to_i
    @time1 = options['time1']
    @time2 = options['time2']
    @time3 = options['time3']
  end

  def save()
    sql = "INSERT INTO screenings (
    time1,
    time2,
    time3
    ) VALUES (
    '#{ time1 }',
    '#{ time2 }',
    '#{ time3 }'
    ) RETURNING id;"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  # def film()
  #   sql = "SELECT films.* FROM films
  #          INNER JOIN tickets ON tickets.film_id = films.id
  #          WHERE film_id = #{@id};"
  #   films_hash = SqlRunner.run(sql)
  #   films_objects = films_hash.map {|film| Film.new(film) }
  #   return films_objects
  # end

  def Screening.all()
    sql = "SELECT * FROM screenings"
    return Screening.get_many(sql)
  end

  def Screening.delete_all() 
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def Screening.get_many(sql)
    screenings = SqlRunner.run(sql)
    return screenings.map { |screening| Screening.new(screening) }
  end

end