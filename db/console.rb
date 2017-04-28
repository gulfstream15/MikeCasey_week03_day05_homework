require_relative( '../models/customer' )

require( 'pry-byebug' )

customer1 = Customer.new({ 'name' => 'Mike', 'funds' => 40})
customer1.save()
customer2 = Customer.new({ 'name' => 'John', 'funds' => 25})
customer2.save()

binding.pry
nil