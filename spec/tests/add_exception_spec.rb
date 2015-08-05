# rspec spec/tests/add_exception_spec.rb

require 'spec_helper'

describe "AddExceptionSpec" do
  before :all do
    @cid = "#{Faker::Number.number(10)}.#{Faker::Number.number(10)}"

    @description = Faker::Lorem.word
    @is_fatal = [true, false].sample

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_exception({
      description: @description,
      is_fatal: @is_fatal
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
        expect(@result[:params][:t]).to eq "exception"
      end
      it "exd" do
        expect(@result[:params][:exd]).to eq @description
      end
      it "exf" do
        expect(@result[:params][:exf]).to eq (@is_fatal ? 1 : 0)
      end

    end
  end

end
