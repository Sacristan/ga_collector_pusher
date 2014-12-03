# rspec spec/tests/add_event_spec.rb

require 'spec_helper'

describe "AddEventSpec" do
  before :all do
    @instance = GACollectorPusher::Instance cid: 111
  end

  it "should return OK" do
    expect{ @instance.add_event category: "Category" }.not_to eq nil
  end
end