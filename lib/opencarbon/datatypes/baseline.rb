require_relative 'numeric_field_with_units'

module OpenCarbon
  module DataTypes
  
    class Baseline < NumericFieldWithUnits

      attr_accessor :year

      def set_values
        self.year = self.node[self.name]['year']
        super
      end

    end

  end
end