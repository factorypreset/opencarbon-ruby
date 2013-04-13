require 'json'

module OpenCarbon

  class CityReport

    attr_accessor :data

    # Load an opencarbon city report file and create ruby objects
    #
    # @param filename [String]
    def initialize(filename)

      self.data = []

      File.open(filename, 'r') do |file|
        content = file.read
        self.data = JSON.parse(content)
      end
    end

    # Return document title
    def title
      self.data['title']
    end

    # Return document reporting period
    def reporting_period
      self.data['reportingPeriod']
    end

  end

end
