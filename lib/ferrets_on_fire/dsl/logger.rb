require 'colorize'
require 'benchmark'

module FerretsOnFire::DSL::Logger
  COLORS = {
      info: :white,
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
      question: '❓ ',
      action: '⚙️ '
  }.freeze

  DEFAULT_PREFIXES = {
      info: '[i]',
      warn: '[!]',
      error: '[X]',
      success: '[✔]',
      question: '[?]',
      action: '[$]'
  }.freeze

  SUFFIXES = {
      info: '',
      warn: '',
      error: '',
      success: '',
      question: ' >',
      action: ''
  }.freeze

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
  # @param [Boolean] output (Optional, default is true). Print the question?
  # @return [String] The question
  public def question(msg, output = true)
    puts log(msg, :question) if output
  end


  public def linebreak
    puts
  end


  public def crash(msg, output, command: nil, exit_on_failure: true)
    error msg
    puts
    puts ' ============='
    puts "COMMAND: #{command}" unless command.nil?
    puts output
    puts ' ============='
    puts
    exit 1 if exit_on_failure
  end

  # Logs that an action will happen. You have to call action_end after that
  # @param [String] msg Message to display
  public def action(msg, &block)
    print log(msg, :action, '  ...  ')
    cmd_output = ''
    bm = ::Benchmark.measure { cmd_output = yield }
    time = '%.2f' % bm.real.round(2)
    info = "#{time.rjust(6)}s"
    puts "\r#{log(msg, :success, info)}"

    [cmd_output, $?.to_i]
  end


  private def log(msg, type, info = '')
    prefix = (RUBY_PLATFORM.include?('darwin') && $stdout.tty? ? FANCY_PREFIXES : DEFAULT_PREFIXES)[type]
    suffix = SUFFIXES[type]
    color = COLORS[type]

    info = info.empty? ? '' : "[#{info}] "

    "#{prefix} #{info}#{msg}#{suffix}".send(color)
  end
end
