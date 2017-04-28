require_relative( '../models/customer' )
require_relative( '../models/film' )

require( 'pry-byebug' )

customer1 = Customer.new({ 'name' => 'Mike', 'funds' => 40})
customer1.save()
customer2 = Customer.new({ 'name' => 'John', 'funds' => 25})
customer2.save()

film1 = Film.new({ 'title' => 'Batman Begins', 'price' => 10})
# film1.save()
film2 = Film.new({ 'title' => 'Spiderman Ends', 'price' => 8})
# film2.save()

binding.pry
nil