require_relative("../db/sql_runner")
require_relative("../models/film")
require_relative("../models/customer")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (
    customer_id, 
    film_id 
    ) VALUES (
    '#{ @customer_id }', 
    '#{ @film_id }'
    ) 
    RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def film()
    sql = "SELECT * FROM films WHERE id = #{film_id}"
    film = SqlRunner.run(sql).first
    Film.new(film)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{customer_id}"
    customer = SqlRunner.run(sql).first
    Customer.new(customer)
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    return Ticket.get_many(sql)
  end

  def Ticket.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def Ticket.get_many(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end


end