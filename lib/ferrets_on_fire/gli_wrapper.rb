require 'gli'

class FerretsOnFire::GliWrapper
  include GLI::App

  public def initialize(desc, commands, options, switches, arguments)
    @_desc = desc
    @_commands  = commands || []
    @_options   = options || []
    @_switches  = switches || []
    @_arguments = arguments || []

    _setup_basics
    _setup_switches
    _setup_options
    _setup_commands
  end

  private def _setup_basics
    program_desc @_desc
  end

  private def _setup_switches
    @_switches.each do |s|
      switch [s.short, s.name], default_value: s.default, desc: s.desc
    end
  end

  private def _setup_options
    @_options.each do |opt|
      flag [opt.short, opt.name], arg_name: opt.param_name, default_value: opt.default,
           desc: opt.desc, required: !opt.default.nil?
    end
  end

  private def _setup_commands
    @_commands.each do |cmd|
      desc cmd.desc
      command cmd.name do |api|
        api.action do |global_options, options, args|
          cmd.global_options = global_options
          cmd.options = options
          cmd.args = args
          cmd.action_block.call
        end
      end

      default_command(cmd.name) if cmd.default
    end
  end
end
