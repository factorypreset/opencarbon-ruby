require_relative 'list_item'

module OpenCarbon
  module DataTypes
  
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

  end
end