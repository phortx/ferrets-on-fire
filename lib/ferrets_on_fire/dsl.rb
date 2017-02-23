module FerretsOnFire::DSL
  require 'ferrets_on_fire/dsl/declaration'
  require 'ferrets_on_fire/dsl/shell'
  require 'ferrets_on_fire/dsl/logger'
  require 'ferrets_on_fire/dsl/git'

  include FerretsOnFire::DSL::Declaration
  include FerretsOnFire::DSL::Shell
  include FerretsOnFire::DSL::Logger
  include FerretsOnFire::DSL::Git

  public def get(name)
    @options[name.to_sym] || @global_options[name.to_sym]
  end
end
