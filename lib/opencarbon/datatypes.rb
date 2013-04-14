module OpenCarbon

  module DataTypes
  
    # Generic field datatype
    class NamedField

      attr_accessor :node, :name

      # Constructor
      #
      # param node [JSON element]
      def initialize(node)
        self.node = node
        self.name = self.node.keys.first
      end

    end

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
        # this is probably too generic to be useful... should be overridden in subclass
        item = NamedField.new(node)
        self.collection << item
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

    # Generic list item datatype
    class ListItem

      def initialize(node)
        self.node = node
        # TODO figure out if anything else is needed here...
      end

    end

    # Generic list datatype
    class NamedList

      attr_accessor :node, :list

      def initialize(node, name)
        self.node = node
        self.list = []

        self.process(name)
      end

      def process(name)
        self.node[name].each do |item|
          self << item
        end
      end

      # Append to list
      #
      # param node [JSON element]
      def <<(node)
        list_item = ListItem.new(node)
        self.list << list_item
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

      # Append to collection
      #
      # param node [JSON element]
      def <<(node)
        scope = Scope.new(node)
        self.collection << scope
      end

    end

    # Source attribution
    class Source < ListItem

      attr_accessor :node, :title, :author, :url

      # Constructor
      #
      # param node [JSON element]
      def initialize(node)
        self.node = node
        self.title = node['title']
        self.author = node['author']
        self.url = node['url']
      end

    end

    # A collection of Sources
    class Sources < NamedList

      def initialize(node)
        self.node = node
        self.list = []
        self.process('sources')
      end

      # Append to list
      #
      # param node [JSON element]
      def <<(node)
        source = Source.new(node)
        self.list << source
      end

    end

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