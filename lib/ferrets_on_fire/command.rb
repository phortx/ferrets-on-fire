require 'ferrets_on_fire/dsl'

class FerretsOnFire::Command
  attr_reader :name, :desc, :default, :action_block
  attr_accessor :global_options, :options, :args

  include FerretsOnFire::DSL

  public def initialize(name, desc, default, &block)
    @name = name.to_sym
    @desc = desc
    @default = default

    define_singleton_method(:dispatch, block)
    dispatch
  end

  public def action(&block)
    @action_block = block
  end

  public def run
    yield @block
  end
end
