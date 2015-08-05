# rspec spec/tests/add_page_view_spec.rb

require 'spec_helper'

describe "AddPageViewSpec" do
  before :all do
    @cid = "#{Faker::Number.number(10)}.#{Faker::Number.number(10)}"

    @hostname = Faker::Lorem.word
    @page = Faker::Lorem.word
    @title = Faker::Lorem.word

    @instance = GACollectorPusher::Instance.new cid: @cid
    @result = @instance.add_page_view({
      hostname: @hostname,
      page: @page,
      title: @title
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
        expect(@result[:params][:t]).to eq "pageview"
      end
      it "dh" do
        expect(@result[:params][:dh]).to eq @hostname
      end
      it "dp" do
        expect(@result[:params][:dp]).to eq @page
      end
      it "dt" do
        expect(@result[:params][:dt]).to eq @title
      end

    end
  end

end
