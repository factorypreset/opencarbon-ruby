require 'spec_helper'

describe "NamedField" do

  before(:each) do
    node_string = '{ "a_field": {"some_datapoint": 20}}'
    node_json = JSON.parse(node_string)

    @node = OpenCarbon::DataTypes::NamedField.new(node_json)
  end

  it "can get the node name" do
    @node.name.should eq "a_field"
  end

end

describe "NumericFieldWithUnits" do
  
  before(:each) do
    node_string = '{ "fieldname": {"numericAmount": 400000, "unitOfMeasurement": "tonnes CO2e"} }'
    node_json = JSON.parse(node_string)

    @node = OpenCarbon::DataTypes::NumericFieldWithUnits.new(node_json)
  end

  it "can get the node name" do
    @node.name.should eq "fieldname"
  end

  it "can get the node amount value" do
    @node.value.should eq 400000
  end

  it "can get the unit of measurement" do
    @node.units.should eq "tonnes CO2e"
  end

  it "can format value and units" do
    @node.pretty.should eq "400000 tonnes CO2e"
  end

end

describe "Baseline" do

  before(:each) do
    node_string = '{ "baseline": {"year": "2007", "numericAmount": 400000, "unitOfMeasurement": "tonnes CO2e"} }'
    node_json = JSON.parse(node_string)

    @baseline = OpenCarbon::DataTypes::Baseline.new(node_json)
  end

  it "can get the year" do
    @baseline.year.should eq "2007"
  end

  it "can still get the amount value" do
    @baseline.value.should eq 400000
  end

end

describe "Total" do

  before(:each) do
    node_string = '{ "total": {"numericAmount": 400000, "unitOfMeasurement": "tonnes CO2e"} }'
    node_json = JSON.parse(node_string)

    @total = OpenCarbon::DataTypes::Total.new(node_json)
  end

  it "can get the node name" do
    @total.name.should eq "total"
  end

end

describe "Scope" do

  before(:each) do
    node_string = '{ "scope-1": {"numericAmount": 400000, "unitOfMeasurement": "tonnes CO2e"} }'
    node_json = JSON.parse(node_string)

    @scope = OpenCarbon::DataTypes::Scope.new(node_json)
  end

  it "can get the node name" do
    @scope.name.should eq "scope-1"
  end

end

describe "Collection" do

  before(:each) do
    node_string = '{ "things": {"first_thing": {"numericAmount": 7794880, "unitOfMeasurement": "tonnes CO2e"}, "second_thing": {"numericAmount": 7131984, "unitOfMeasurement": "tonnes CO2e"} } }'
    node_json = JSON.parse(node_string)

    @things = OpenCarbon::DataTypes::Collection.new(node_json, 'things')
  end

  it "can get items" do
    @things.collection.size.should eq 2
  end

  it "can get the name for a particular item" do
    @things.collection.first.name.should eq "first_thing"
  end

  it "can get an item from the collection by name" do
    thing = @things.find_by_name("second_thing")
    thing.should_not be_nil
    thing.name.should eq "second_thing"
  end

  it "can handle finding non-existent items" do
    # look for an item that is not contained in the collection
    thing = @things.find_by_name("a_non_existent_thing")
    thing.should be_nil
  end

end

describe "Scopes" do

  before(:each) do
    node_string = '{ "scopes": {"scope-1": {"numericAmount": 7794880, "unitOfMeasurement": "tonnes CO2e"}, "scope-2": {"numericAmount": 7131984, "unitOfMeasurement": "tonnes CO2e"} } }'
    node_json = JSON.parse(node_string)

    @scopes = OpenCarbon::DataTypes::Scopes.new(node_json)
  end

  it "can get a list of scopes" do
    @scopes.collection.size.should eq 2
  end

end

describe "Source" do

  before(:each) do
    node_string = '{
        "title": "CDP 2012 CDP Cities 2012 Information Request",
        "author": "City of Austin",
        "url": "http://www.austintexas.gov/sites/default/files/files/Sustainability/Climate/ProgrammeResponse_2010Final.pdf"
      }'
    node_json = JSON.parse(node_string)

    @source = OpenCarbon::DataTypes::Source.new(node_json)
  end

  it "can get a source document's title" do
    @source.title.should eq "CDP 2012 CDP Cities 2012 Information Request"
  end

  it "can get a source document's author" do
    @source.author.should eq "City of Austin"
  end

  it "can get a source document's url" do
    @source.url.should eq "http://www.austintexas.gov/sites/default/files/files/Sustainability/Climate/ProgrammeResponse_2010Final.pdf"
  end

end

describe "Sources" do

  before(:each) do
    node_string = '{"sources": [
      {
        "title": "CDP 2012 CDP Cities 2012 Information Request",
        "author": "City of Austin",
        "url": "http://www.austintexas.gov/sites/default/files/files/Sustainability/Climate/ProgrammeResponse_2010Final.pdf"
      },
      {
        "title": "Another source doc",
        "author": "An author",
        "url": "http://www.example.org/some_doc.pdf"
      }
    ]}'
    node_json = JSON.parse(node_string)

    @sources = OpenCarbon::DataTypes::Sources.new(node_json)
  end

  it "can get a list of sources" do
    @sources.list.size.should eq 2
  end

end

describe "Profile" do

  before(:each) do
    node_string = '{
      "profile": {
        "geographicArea": 770,
        "geographicAreaUnits": "sq km",
        "population": 820611,
        "climateZone": "US Zone 5",
        "annualHeatingDegreeDays": 1688,
        "annualCoolingDegreeDays": 3016
      }
    }'
    node_json = JSON.parse(node_string)

    @profile = OpenCarbon::DataTypes::Profile.new(node_json)
  end

  it "can get profile data" do
    @profile.geographic_area.should eq 770
    @profile.geographic_area_units.should eq "sq km"
    @profile.geographic_area_pretty.should eq "770 sq km"
    @profile.population.should eq 820611
    @profile.climate_zone.should eq "US Zone 5"
    @profile.annual_heating_degree_days.should eq 1688
    @profile.annual_cooling_degree_days.should eq 3016
  end

end