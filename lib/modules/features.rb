module Features
  class Feature
    attr_accessor :name, :type, :default, :initialized, :caption, :values

    def initialize(**args)
      @name = args[:name]
      @caption = args[:caption]
      @type = args[:type]
      @default = args[:default] || ''
      @values = args[:values]
      @initialized = true
    end

    def initialized?
      @initialized || false
    end

    def _to_h
      { name: @name, type: @type, caption: @caption }
    end
  end
end
