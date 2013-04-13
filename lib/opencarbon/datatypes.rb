require 'json'

module OpenCarbon

  module DataTypes
  
    class NumericFieldWithUnits

      attr_accessor :name, :value, :units

      def initialize(node)
        self.name = node.keys.first
        self.value = node[self.name]['numericAmount']
        self.units = node[self.name]['unitOfMeasurement']
      end

      def pretty
        "#{self.value} #{self.units}"
      end

    end

  end

end