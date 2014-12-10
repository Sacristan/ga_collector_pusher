# rspec spec/tests/add_transaction_spec.rb

require 'spec_helper'

describe "AddTransactionSpec" do
  before :all do
    @instance = GACollectorPusher::Instance.new cid: 5555
  end

  it "should return OK" do
    result = @instance.add_transaction ({
        transaction_id: 1,
        total: 1,
        store_name: "www.place.com"
    }
    )
    puts result.inspect
    expect(result).not_to eq nil
  end
end