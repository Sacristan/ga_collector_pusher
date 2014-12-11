# rspec spec/tests/add_item_spec.rb

require 'spec_helper'

describe "AddEventSpec" do
  before :all do
    @cid = "#{Faker::Number.number(6)}.#{Faker::Number.number(6)}"
    @transaction_id = Faker::Number.number(8)
    @item_sku = Faker::Commerce.department
    @price = Faker::Commerce.price
    @quantity = Faker::Number.number(2).to_i
    @name = Faker::Commerce.product_name
    @category = Faker::Lorem.word

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_item({
      transaction_id: @transaction_id,
      item_sku: @item_sku,
      price: @price,
      quantity: @quantity,
      name: @name,
      category: @category
    })
    puts @result.inspect
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
        expect(@result[:params][:t]).to eq "item"
      end
      it "ti" do
        expect(@result[:params][:ti]).to eq @transaction_id
      end
      it "in" do
        expect(@result[:params][:in]).to eq @name
      end
      it "ip" do
        expect(@result[:params][:ip]).to eq @price
      end
      it "iq" do
        expect(@result[:params][:iq]).to eq @quantity
      end
      it "ic" do
        expect(@result[:params][:ic]).to eq @item_sku
      end
      it "iv" do
        expect(@result[:params][:iv]).to eq @category
      end
    end
  end
end