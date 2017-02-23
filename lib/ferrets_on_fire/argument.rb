class FerretsOnFire::Argument
  attr_reader :name, :short, :default, :desc

  public def initialize(name, default, desc)
    @name = name.to_sym
    @default = default
    @desc = desc
  end
end
