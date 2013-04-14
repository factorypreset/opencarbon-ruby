require_relative 'collection'

module OpenCarbon
  module DataTypes
  
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

  end

end