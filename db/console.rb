require_relative( '../models/customer' )
require_relative( '../models/film' )
require_relative( '../models/ticket' )
require_relative( '../models/screening' )

require( 'pry-byebug' )

customer1 = Customer.new({ 'name' => 'Mike', 'funds' => 40})
customer1.save()
customer2 = Customer.new({ 'name' => 'John', 'funds' => 25})
customer2.save()
customer3 = Customer.new({ 'name' => 'Bob', 'funds' => 50})
customer3.save()

film1 = Film.new({ 'title' => 'Batman Begins', 'price' => 10})
film1.save()
film2 = Film.new({ 'title' => 'Spiderman Ends', 'price' => 8})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4.save()

screening1 = Screening.new({'time' => 'hello'})
screening1.save()
screening2 = Screening.new({'time' => 'goodbye'})
screening2.save()
screening3 = Screening.new({'time' => 'staying'})
screening3.save()

binding.pry
nil