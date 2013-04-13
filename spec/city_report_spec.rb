require 'spec_helper'

module OpenCarbon

  describe CityReport do

    before(:each) do
      @report = OpenCarbon::CityReport.new('spec/fixtures/cities/austin.json')
    end

    it "can get the title of an example city report" do
      @report.title.should == 'Austin Carbon Inventory 2010'
    end

    it "can get the reporting year of an example city report" do
      @report.reporting_period['year'].should == '2010'
    end

  end

end