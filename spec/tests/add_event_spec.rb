# rspec spec/tests/add_event_spec.rb

require 'spec_helper'

describe "AddEventSpec" do
  before :all do
    @instance = GACollectorPusher::Instance.new cid: 5555
  end

  it "should return OK" do
    result = @instance.add_event category: "Category"
    puts result.inspect
    expect(result).not_to eq nil
  end
end