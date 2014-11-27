require 'rails_helper'

describe Order do
  # it { should have_attribute(:status) }
  # it { should have_attribute(:address) }
  # it { should have_many(:order_items) }
  # it { should have_many(:items) }
  # it { should belong_to(:user) }

  describe "relationships" do
    it "has many items" do
      item = Item.create(title: "title", price: 10, description: "description")
      order = Order.create(user_id: 1, status: "ordered")
      OrderItem.create(item_id: item.id, order_id: order.id)
      expect(order.items.first).to eq(item)
    end

    it "belongs to a user" do
      user = User.create
      order = Order.create(user_id: user.id, status: "ordered")

      user.orders << order
      expect(order.user).to eq(user)
    end
  end

  it 'should default status to ordered' do
    order = Order.create(address: "address is nice")
    expect(order.status).to eq("ordered")
  end

  describe "validations" do
    it "must have a user_id" do
      order = Order.create(user_id: nil)
      expect(order).to_not be_valid
    end
  end

  describe "delivery orders" do
    it "must have an address" do
      order = Order.create(user_id: 1, delivery: true, address: nil)
      expect(order).to_not be_valid
    end
  end
end
