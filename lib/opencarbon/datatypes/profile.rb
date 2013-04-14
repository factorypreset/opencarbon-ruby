require_relative 'named_field'

module OpenCarbon
  module DataTypes
  
    class Profile < NamedField

      attr_accessor :geographic_area, :geographic_area_units, :geographic_area_pretty, :population, :climate_zone, :annual_heating_degree_days, :annual_cooling_degree_days

      def initialize(node)
        self.node = node
        self.name = self.node.keys.first

        self.geographic_area = node[self.name]['geographicArea']
        self.geographic_area_units = node[self.name]['geographicAreaUnits']
        self.geographic_area_pretty = "#{self.geographic_area} #{self.geographic_area_units}"
        self.population = node[self.name]['population']
        self.climate_zone = node[self.name]['climateZone']
        self.annual_heating_degree_days = node[self.name]['annualHeatingDegreeDays']
        self.annual_cooling_degree_days = node[self.name]['annualCoolingDegreeDays']
      end

    end

  end
end