class FerretsOnFire::Option
  attr_reader :name, :short, :param_name, :default, :desc

  public def initialize(name, short, param_name, default, desc)
    @name = name.to_sym
    @short = short.to_sym
    @param_name = param_name
    @default = default
    @desc = desc
  end
end
