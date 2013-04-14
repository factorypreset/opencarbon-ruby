require_relative 'named_field'

module OpenCarbon
  module DataTypes
  
    # Generic datatype for numeric data with a unit of measure
    class NumericFieldWithUnits < NamedField

      attr_accessor :node, :name, :value, :units

      # Constructor
      #
      # param node [JSON element]
      def initialize(node)
        self.node = node
        self.name = self.node.keys.first
        self.set_values()
      end

      def set_values
        self.value = self.node[self.name]['numericAmount']
        self.units = self.node[self.name]['unitOfMeasurement']
      end

      def pretty
        "#{self.value} #{self.units}"
      end

    end

  end
end