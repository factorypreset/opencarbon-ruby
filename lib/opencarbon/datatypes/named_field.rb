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

  end
end