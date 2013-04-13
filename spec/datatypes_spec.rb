require 'spec_helper'

describe "NumericFieldWithUnits" do
  
  before(:each) do
    node_string = '{ "baseline": {"numericAmount": 400000, "unitOfMeasurement": "tonnes CO2e"} }'
    node_json = JSON.parse(node_string)

    @node = OpenCarbon::DataTypes::NumericFieldWithUnits.new(node_json)
  end

  it "can get the node name" do
    @node.name.should eq "baseline"
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