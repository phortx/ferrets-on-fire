class FerretsOnFire::Switch
  attr_reader :name, :short, :default, :desc

  public def initialize(name, short, default, desc)
    @name = name.to_sym
    @short = short.to_sym
    @default = default
    @desc = desc
  end
end
