require_relative("../db/sql_runner")
require_relative("../models/film")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (
    name,
    funds
    ) VALUES (
    '#{ @name }',
    #{funds}
    ) RETURNING id;"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  def update()
    sql = "
    UPDATE customers SET (
      name,
      funds
    ) = (
     '#{ @name }',
      #{funds}
    ) 
    WHERE id = #{@id};"
          
    SqlRunner.run(sql)
  end
  
  def films()
    sql = "SELECT films.* FROM films
           INNER JOIN tickets ON tickets.film_id = films.id
           WHERE customer_id = #{@id};"
    films_hash = SqlRunner.run(sql)
    films_objects = films_hash.map {|film| Film.new(film) }
    return films_objects
  end

  def cost_for_chosen_films()
    sql = "SELECT films.* FROM films
           INNER JOIN tickets ON tickets.film_id = films.id
           WHERE customer_id = #{@id};"
    films_hash = SqlRunner.run(sql)
    films_objects = films_hash.map {|film| Film.new(film) }
    cost = 0
    for object in films_objects
      cost += object.price
    end
    return cost 
  end

  def funds_remaining()
    funds_remaining = @funds - cost_for_chosen_films()
    return funds_remaining
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets
           WHERE customer_id = #{@id};"
    tickets_hash = SqlRunner.run(sql)
    tickets_objects = tickets_hash.map {|ticket| Ticket.new(ticket) }
    return tickets_objects
  end

  def number_of_tickets()
    sql = "SELECT tickets.* FROM tickets
           WHERE customer_id = #{@id};"
    count = 0
    tickets_hash = SqlRunner.run(sql)
    tickets_objects = tickets_hash.map {|ticket| Ticket.new(ticket) }
    for object in tickets_objects
      count += 1
    end
    return count
  end

  def Customer.find(id)
    sql = "SELECT * FROM films WHERE id = #{id};"
    films = SqlRunner.run(sql)
    film_hash = films.first
    film_objects = Customer.new(film_hash)
    return film_objects
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end

  def Customer.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.get_many(sql)
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

end