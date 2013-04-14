require_relative 'named_list'
require_relative 'source'

module OpenCarbon

  module DataTypes
  
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

  end

end