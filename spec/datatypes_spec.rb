require 'spec_helper'

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
    thing.value.should eq 7131984
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

  it "can get scopes" do
    @scopes.collection.size.should eq 2
  end

end