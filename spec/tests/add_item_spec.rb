# rspec spec/tests/add_item_spec.rb

require 'spec_helper'

describe "AddEventSpec" do
  before :all do
    @instance = GACollectorPusher::Instance.new cid: 5555
  end

  it "should return OK" do
    result = @instance.add_item({
      transaction_id: 1,
      item_sku: "Item Store",
      price: 0.01,
      quantity: 5,
      name: "A wonderful Item",
      category: "Item Category"
    })

    puts result.inspect
    expect(result).not_to eq nil
  end
end