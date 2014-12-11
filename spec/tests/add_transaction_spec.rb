# rspec spec/tests/add_transaction_spec.rb

require 'spec_helper'

describe "AddTransactionSpec" do
  before :all do
    @cid = "#{Faker::Number.number(6)}.#{Faker::Number.number(6)}"
    @transaction_id = Faker::Number.number(8)
    @total = Faker::Commerce.price
    @store_name = Faker::Company.name
    @tax = Faker::Number.number(2)
    @shipping = Faker::Address.street_address
    @city = Faker::Address.city
    @region = Faker::Address.state
    @country = Faker::Address.country

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_transaction ({
      transaction_id: @transaction_id,
      total: @total,
      store_name: @store_name,
      tax: @tax,
      shipping: @shipping,
      city: @city,
      region: @region,
      country: @country
    })
    puts @result
  end

  it "status should be sent" do
    expect(@result[:status]).to eq "sent"
  end

  it "should return GA GIF" do
    expect(@result[:response]).not_to eq nil
  end

  context "fields" do
    context "should be present" do
      it "v" do
        expect(@result[:params][:v]).to eq GOOGLE_ANALYTICS_SETTINGS[:version]
      end
      it "tid" do
        expect(@result[:params][:tid]).to eq GOOGLE_ANALYTICS_SETTINGS[:tracking_code]
      end
      it "cid" do
        expect(@result[:params][:cid]).to eq @cid
      end
      it "t" do
        expect(@result[:params][:t]).to eq "transaction"
      end
      it "ti" do
        expect(@result[:params][:ti]).to eq @transaction_id
      end
      it "tr" do
        expect(@result[:params][:tr]).to eq @total
      end
    end
  end

 
end