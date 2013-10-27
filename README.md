takeaway
========

This challenge formed part 2 of 2 of the Week 4 test at Makers Academy.

The aim was to write a class Takeaway with the following functionality:

- print a list of dishes with prices

- a customer can place an order by giving a list of dishes, their quantities, and a number that should be the exact total cost of the order
  
  The format for placing orders is as follows:

  customer.place_order_at takeaway, {'dish1' => quantity, 'dish2 => quantity}, order_total

- if the order total is not correct, an error should be raised

- if it is correct, a text should be delievered to the customer's phone confirming their order and saying that it will be delivered within the next hour.

The Twilio API was used to implement the SMS functionality. 

