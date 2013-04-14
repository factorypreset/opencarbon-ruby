module OpenCarbon
  module DataTypes
  
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

  end
end
