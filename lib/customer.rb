class Customer

  def initialize name, mobile_number
    @name = name
    @mobile_number = mobile_number
  end

  def name
    @name
  end

  def mobile_number
    @mobile_number
  end

  def place_order_at takeaway, dishes = {}, customer_total
    takeaway.process_order_from self, dishes, customer_total
  end

end