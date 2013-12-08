#Takeaway
##Makers Academy Week 4 Test, Part II


###Aim

The aim was to write a class Takeaway with the following functionality:

* print a list of dishes with prices

* a customer can place an order by giving a list of dishes, their quantities, and a number that should be the exact total cost of the order

* if the order total is not correct, an error should be raised

* if it is correct, a text should be delievered to the customer's phone confirming their order and saying that it will be delivered within the next hour.

###Other details

The test was set by Enrique Comba Riepenhausen, [@ecomba](http://www.github.com/ecomba)

The format for placing orders is as follows:

  customer.place_order_at takeaway, {'dish1' => quantity, 'dish2 => quantity}, order_total

The Twilio API was used to implement the SMS functionality.

###To do

* Refine method names to make them clearer, e.g. Takeaway#confirmation_message instead of Takeaway#message
* Split the functionality out into more classes, which would enable more scope for development. Possible classes include: Dish, Menu, Order, LineItem, TwilioOrder (initialised with a TwilioWrapper)
* Disguise Twilio details under ENV variables

