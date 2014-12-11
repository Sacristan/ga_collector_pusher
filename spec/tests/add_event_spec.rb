# rspec spec/tests/add_event_spec.rb

require 'spec_helper'

describe "AddEventSpec" do
  before :all do
    @cid = "#{Faker::Number.number(6)}.#{Faker::Number.number(6)}"
    @category = Faker::Lorem.word
    @action = Faker::Lorem.word

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_event({
      category: @category,
      action: @action,
    })
    puts @result.inspect
  end

  it "should return GA GIF" do
    expect(@result[:response]).not_to eq "GIF89a\x01\x00\x01\x00\x80\xFF\x00\xFF\xFF\xFF\x00\x00\x00,\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02D\x01\x00;"
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
        expect(@result[:params][:t]).to eq "event"
      end
      it "ec" do
        expect(@result[:params][:ec]).to eq @category
      end
      it "ea" do
        expect(@result[:params][:ea]).to eq @action
      end
    end
  end



end