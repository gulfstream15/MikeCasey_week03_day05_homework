require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :time

  def initialize( options )
    @id = options['id'].to_i
    @time = options['time']
  end

  def save()
    sql = "INSERT INTO screenings (
    time
    ) VALUES (
    '#{ @time }'
    ) RETURNING id"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

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