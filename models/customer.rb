require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name) VALUES ('#{ @name }') RETURNING id"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  def films()
    sql = "SELECT films.* FROM films
           INNER JOIN tickets ON tickets.film_id = films.id
           WHERE customer_id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map {|film| Film.new(film) }
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets
           WHERE customer_id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map {|ticket| Ticket.new(ticket) }
  end

  # def total_tickets()
  #   sql = "SELECT tickets.* FROM tickets
  #          WHERE customer_id = #{@id};"
  #   results = SqlRunner.run(sql)
  #   return results.length()
  # end

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