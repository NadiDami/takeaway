require 'twilio-ruby'

class Takeaway

#Twilio details
  ACCOUNT_SID = "AC8400347f29cf44f58d5339e8a23b1d2b"
  AUTH_TOKEN = "82250c8827bf9ea16a07dcac25618ccb"
  FROM_NUMBER = "+44 1270 261004"

  def initialize menu={}
    @menu = menu
    
  end

  def twilio_client
    @twilio_client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end

  def add_dish_to_menu dish_name, price
    @menu[dish_name] = price
  end

  def print_menu
    @menu
  end

  def send_confirmation_message_to customer
      twilio_client.account.messages.create(
      :from => FROM_NUMBER,
      :to => customer.mobile_number,
      :body => message
    )
     "Your confirmation message has been sent to #{customer.name}."

  end

  def order_total dishes={}
    dishes.map.inject(0) do |total, (key,value)|
       total += dishes[key] * @menu[key]
       total
    end
  end
      
  
  def message
    "Thank you! Your order was placed and will be delivered before #{one_hour_from_now}"
  end

  def one_hour_from_now
    (Time.now + 60 * 60).strftime("%H:%M")
  end

  def process_order_from customer, dishes={}, customer_total
    raise "I'm sorry. Your order could not be processed since the calcualated total is incorrect." if customer_total != order_total(dishes)
    send_confirmation_message_to customer
  end



end