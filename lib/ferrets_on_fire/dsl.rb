module FerretsOnFire::DSL
  require 'ferrets_on_fire/dsl/declaration_dsl'
  require 'ferrets_on_fire/dsl/shell_dsl'
  require 'ferrets_on_fire/dsl/logger_dsl'
  require 'ferrets_on_fire/dsl/git_dsl'

  include FerretsOnFire::DSL::DeclarationDSL
  include FerretsOnFire::DSL::ShellDSL
  include FerretsOnFire::DSL::LoggerDSL
  include FerretsOnFire::DSL::GitDSL

  public def get(name)
    @options[name.to_sym] || @global_options[name.to_sym]
  end

  public def root
    require 'bundler'
    ::Bundler.root
  end

  public def load_lib
    $: << "#{root}/lib"
  end
end
