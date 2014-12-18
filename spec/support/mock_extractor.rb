module NZMPsPopolo
  class MockExtractor
    attr_reader :options, :methods_called

    def initialize(options)
      @options = options
      @methods_called = []
    end

    def method_missing(meth, *args, &block)
      @methods_called << meth
    end
  end
end
