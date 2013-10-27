require 'takeaway'

describe Takeaway do

  let(:takeaway) { Takeaway.new {} }
  let(:takeaway2) { Takeaway.new 'jollof rice' => 8, 'pepper soup' => 5 }
  let(:customer) { double :customer, mobile_number: "+447825127938" }
  let(:twilio_client) { double :twilio_client }
  let(:customer_total) { double :customer_total }

  context 'with the restaurant\'s menu' do

    it 'can add one dish with its price to the menu' do
      takeaway.add_dish_to_menu('jollof rice', 8)
      expect(takeaway.print_menu).to eq({'jollof rice' => 8})
    end

    it 'can add multiple dishes with their prices to the menu' do
      expect(takeaway2.print_menu).to eq({'jollof rice' => 8, 'pepper soup' => 5})
    end

  end

  context 'when a customer is ordering, the takeaway system' do

    it 'has a client to talk to the Twilio REST API' do
       expect(Twilio::REST::Client).to receive(:new).and_return(twilio_client)
       expect(takeaway.twilio_client).to eq twilio_client
    end

    it 'can send a confirmation text message to the customer' do
      account = double :account
      messages  = double :messages
      message = double :message
      expect(customer).to receive(:name)
      expect(takeaway).to receive(:twilio_client).and_return(twilio_client)
      expect(twilio_client).to receive(:account).and_return(account)
      expect(account).to receive(:messages).and_return(messages)
      expect(messages).to receive(:create)
      takeaway.send_confirmation_message_to customer 
    end


    it 'can calculate the correct order total' do
      expect(takeaway2.order_total({'jollof rice' => 1, 'pepper soup' => 1})).to eq 13 
    end

    it 'can calculate the correct order total with repeated dishes' do
      expect(takeaway2.order_total({'jollof rice' => 3, 'pepper soup' => 2})).to eq 34
    end

    it 'raises an error message if the customer total is incorrect' do
      expect(lambda { takeaway2.process_order_from( customer, {'jollof rice' => 2, 'pepper soup' => 1}, 20)}).to raise_error(RuntimeError)
    end

    it 'calculates the time one hour after the order was placed' do
      time = Time.new(1,1,1,8)
      Time.should_receive(:now).and_return(time)
      expect(takeaway.one_hour_from_now).to eq "09:00"
    end

    it 'sends a confirmation text message if the customer total is correct' do
      expect(takeaway2).to receive(:send_confirmation_message_to)
      takeaway2.process_order_from( customer, {'jollof rice' => 2, 'pepper soup' => 1}, 21)
    end

    it 'includes in the confirmation message a delivery time of up to one hour' do
      expect(takeaway.message).to include takeaway.one_hour_from_now
    end

  end

end