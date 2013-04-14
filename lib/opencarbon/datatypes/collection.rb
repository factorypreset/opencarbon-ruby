require_relative 'named_field'

module OpenCarbon
  module DataTypes
  
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

  end
end