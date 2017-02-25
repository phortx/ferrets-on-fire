module FerretsOnFire
  require 'ferrets_on_fire/dsl'
  include FerretsOnFire::DSL

  # FIXME does that work?
  public def call
    @gli = _setup_gli
    @gli.run(ARGV)
    exit
  end


  private def _setup_gli
    GliWrapper.new(@desc, @commands, @options, @switches, @arguments)
  end
end
