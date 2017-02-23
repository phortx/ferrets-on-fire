module FerretsOnFire
  require 'ferrets_on_fire/dsl'
  include FerretsOnFire::DSL

  public def execute
    @gli = setup_gli
    @gli.run(ARGV)
    exit
  end


  public def setup_gli
    GliWrapper.new(@desc, @commands, @options, @switches, @arguments)
  end
end
