module OpenCarbon

  module DataTypes
  
    # Generic datatype for numeric data with a unit of measure
    class NumericFieldWithUnits

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

    class Baseline < NumericFieldWithUnits

      attr_accessor :year

      def set_values
        self.year = self.node[self.name]['year']
        super
      end

    end

    class Total < NumericFieldWithUnits
    end

    class Scope < NumericFieldWithUnits
    end

    # Generic collection datatype
    class Collection

      attr_accessor :node, :collection

      def initialize(node, base_element)
        self.node = node
        self.collection = []

        self.process(base_element)
      end

      def process(base_element)
        items = self.node[base_element]

        items.keys.each do |key|
          new_node = {}
          new_node[key] = self.node[base_element][key]
          self << new_node
        end
      end

      # Append to collection
      #
      # param node [JSON element]
      def <<(node)
        scope = Scope.new(node)
        self.collection << scope
      end

      # Get the named element from collection
      #
      # param name [String]
      def find_by_name(name)
        for item in self.collection
          return item if item.name == name
        end

        # didn't find item in collection, return nil
        return nil
      end

    end

    # A collection of Scopes
    class Scopes < Collection

      # Constructor
      #
      # param node [JSON element]
      def initialize(node, base_element='scopes')
        self.node = node
        self.collection = []
        self.process(base_element)
      end

    end

    # Source attribution
    class Source

    end

  end

end