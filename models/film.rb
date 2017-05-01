require_relative("../db/sql_runner")

class Film 

  attr_reader :id
  attr_accessor :title, :price 

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (
    title,
    price
    ) VALUES (
    '#{ @title }',
    #{price}
    ) RETURNING id"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  def update()
    sql = "
    UPDATE films SET (
      title,
      price
    ) = (
     '#{ @title }',
      #{price}
    ) 
    WHERE id = #{@id};"
          
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
           INNER JOIN tickets ON tickets.customer_id = customers.id
           WHERE film_id = #{@id};"
    return Customer.get_many(sql)
  end

  def how_many_customers()
    sql = "SELECT customers.* FROM customers
           INNER JOIN tickets ON tickets.customer_id = customers.id
           WHERE film_id = #{@id};"
    customers_hash = SqlRunner.run(sql)
    customers_objects = customers_hash.map {|customer| Customer.new(customer) }
    count = 0
    for object in customers_objects
      count += 1
    end
    return count
  end

  def Film.all()
    sql = "SELECT * FROM films"
    return Film.get_many(sql)
  end

  def Film.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def Film.get_many(sql)
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

end