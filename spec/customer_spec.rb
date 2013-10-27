require 'customer'

describe Customer do

  let(:customer) {Customer.new 'Nadia','+447123456789' }
  let(:takeaway) {double :takeaway}
  let(:dishes) {double :dishes}
  let(:customer_total) {double :customer_total}

  it 'has a name' do
    expect(customer.name).to eq 'Nadia'
  end

  it 'has a mobile number' do
    expect(customer.mobile_number).to eq "+447123456789"
  end

  context 'when visiting a takeaway' do

    it 'can place an order' do
      expect(takeaway).to receive(:process_order_from)
      customer.place_order_at(takeaway, dishes, customer_total) 
    end

  end

end