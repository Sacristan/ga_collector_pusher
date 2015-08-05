# rspec spec/tests/add_social_spec.rb

require 'spec_helper'

describe "AddSocialSpec" do
  before :all do
    @cid = "#{Faker::Number.number(10)}.#{Faker::Number.number(10)}"

    @action = Faker::Lorem.word
    @network = Faker::Lorem.word
    @target = Faker::Lorem.word

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_social({
      action: @action,
      network: @network,
      target: @target
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
        expect(@result[:params][:t]).to eq "social"
      end
      it "sa" do
        expect(@result[:params][:sa]).to eq @action
      end
      it "sn" do
        expect(@result[:params][:sn]).to eq @network
      end
      it "st" do
        expect(@result[:params][:st]).to eq @target
      end

    end
  end

end
