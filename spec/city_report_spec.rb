require 'spec_helper'

module OpenCarbon

  describe CityReport do

    before(:each) do
      # Load example data (based on Austin 2010 disclosures)
      @report = OpenCarbon::CityReport.new('spec/fixtures/cities/austin.json')
    end

    it "can get the title of an example city report" do
      @report.title.should == 'Austin Carbon Inventory 2010'
    end

    it "can get the reporting year of an example city report" do
      @report.reporting_period['year'].should == '2010'
    end

    it "can get the reporting entity's name" do
      @report.name.should == 'City of Austin'
    end

    it "can attribute sources" do
      @report.sources.size.should eq 1
      @report.sources.first['author'].should == 'City of Austin'
    end

    it "can get the city's population profile" do
      @report.profile['population'].should eq 820611
    end

    it "can get municipal and community emission goals" do
      @report.goals.size.should eq 2
      @report.goals['municipal']['targets'].size.should eq 1
      @report.goals['community']['targets'].size.should eq 2
    end

    it "can list municipal and community emission goals" do
      @report.emission_sources.size.should eq 2
      @report.emission_sources['municipal'].should_not be_nil
      @report.emission_sources['community'].should_not be_nil
    end

    it "can get total municipal and community emissions" do
      @report.municipal_emissions['total']['numericAmount'].should eq 449980  # TODO: wrap numericAmount fields in a generic class
      @report.community_emissions['total']['numericAmount'].should eq 14926864
    end

  end

end