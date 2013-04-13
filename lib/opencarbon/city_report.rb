require 'json'

module OpenCarbon

  class CityReport

    attr_accessor :data

    # Load an opencarbon city JSON report file and create ruby objects
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

    # Document reporting entity (primary container for disclosure data)
    def reporting_entity
      self.data['reportingEntity']
    end

    def name
      self.reporting_entity['name']
    end

    def sources
      self.reporting_entity['sources']
    end

    def profile
      self.reporting_entity['profile']
    end

    def goals
      self.reporting_entity['goals']
    end

    # Emission sources
    def emission_sources
      self.reporting_entity['emissionSources']
    end

    def municipal_emissions
      self.emission_sources['municipal']
    end

    def community_emissions
      self.emission_sources['community']
    end



  end

end
