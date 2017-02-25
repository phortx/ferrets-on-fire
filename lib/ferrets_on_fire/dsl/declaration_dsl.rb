module FerretsOnFire::DSL::DeclarationDSL
  public def description(desc)
    @desc = desc
  end
  alias_method :desc, :description


  public def option(name, short, param_name: 'PARAM', default: nil, desc: '')
    @options ||= []
    @options << Option.new(name, param_name, short, default, desc)
  end
  alias_method :opt, :option


  public def switch(name, short, default: false, desc: '')
    @switches ||= []
    @switches << Switch.new(name, short, default, desc)
  end


  public def argument(name, desc: '', default: nil)
    @arguments ||= []
    @arguments << Argument.new(name, desc, default)
  end
  alias_method :arg, :argument


  public def command(name, desc: '', default: false, &block)
    @commands ||= []
    @commands << Command.new(name, desc, default, &block)
  end
  alias_method :cmd, :command
end
