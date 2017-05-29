require 'colorize'
require 'benchmark'
require 'tty'

module FerretsOnFire::DSL::LoggerDSL
  COLORS = {
      info: nil,
      warn: :yellow,
      error: :red,
      success: :green,
      question: :magenta,
      action: :light_blue
  }.freeze

  FANCY_PREFIXES = {
      info: 'ℹ️️ ',
      warn: '⚠️ ',
      error: '‼️️ ',
      success: '✨ ',
      question: "\n❓ ",
      action: '⚙️ '
  }.freeze

  DEFAULT_PREFIXES = {
      info: '[i]',
      warn: '[!]',
      error: '[X]',
      success: '[✔]',
      question: "\n[?]",
      action: '[$]'
  }.freeze

  SUFFIXES = {
      info: '',
      warn: '',
      error: '',
      success: '',
      question: ' > ',
      action: ''
  }.freeze


  public def banner(string, color: :white, background: :black)
    puts string.colorize(color: color, background: background)
  end

  # Outputs a info message
  # @param [String] msg The message
  public def info(msg)
    puts log(msg, :info)
  end

  # Outputs a warning message
  # @param [String] msg The message
  public def warn(msg)
    puts log(msg, :warn)
  end


  # Outputs a error message
  # @param [String] msg The message
  public def error(msg)
    puts log(msg, :error)
  end



  # Outputs a success message
  # @param [String] msg The message
  public def success(msg)
    puts log(msg, :success)
  end


  # Generates a question with the specified msg. If output is true (default) it will be printed.
  # @param [String] msg The message
  # @param [Array<Object>] options Array of option
  # @return [Object] The chosen option value
  public def choose(msg, options, default: nil)
    default_idx = default.nil? ? 0 : options.index(default)

    get_prompt.select(log(msg + (default.nil? ? '' : " (Default: #{default})"), :question), per_page: 7) do |menu|
      menu.default default_idx + 1
      options.each { |opt| menu.choice opt }
    end
  end

  public def yes_no(msg, default = true)
    answer = nil

    until answer == '' || answer =~ /^(y|n)$/i
      answer = get_prompt.yes?(log(msg, :question)) do |q|
        q.default default
      end
    end

    answer
  end


  private def get_prompt
    TTY::Prompt.new(help_color: :white)
  end


  public def linebreak
    puts
  end

  public def highlight(str)
    str.light_blue
  end


  public def crash(msg, output, command: nil, exit: true)
    puts
    error msg
    puts
    puts '=====================[ CRASH REPORT ]====================='.red

    unless command.nil?
      puts
      puts 'COMMAND: '.red
      puts command
    end

    puts
    puts 'ERROR:'.red
    puts output
    puts
    puts '=========================================================='.red
    puts
    exit 1 if exit
  end

  public def action(msg)
    print log(msg, :action) if $stdout.tty?

    return_value = block_given? ? yield : nil

    puts "\r#{log(msg, :success)}"
    return_value
  end


  # @param [String] msg Message to display
  private def _shell_action(msg)
    print log(msg, :action, '  ...  ') if $stdout.tty?
    cmd_output = ''
    bm = ::Benchmark.measure { cmd_output = yield }
    time = '%.2f' % bm.real.round(2)
    info = "#{time.rjust(6)}s"
    puts ($stdout.tty? ? "\r" : '') + log(msg, :success, info)

    [cmd_output, $?.to_i]
  end


  private def log(msg, type, info = '')
    prefix = (RUBY_PLATFORM.include?('darwin') && $stdout.tty? ? FANCY_PREFIXES : DEFAULT_PREFIXES)[type]
    suffix = SUFFIXES[type]
    color = COLORS[type]

    info = info.empty? ? '' : "[#{info}] "

    output = "#{prefix} #{info}#{msg}#{suffix}"
    color.nil? ? output : output.send(color)
  end
end
