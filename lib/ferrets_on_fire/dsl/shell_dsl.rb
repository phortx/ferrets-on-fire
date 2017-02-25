module FerretsOnFire::DSL::ShellDSL
  public def bundle(dir: nil)
    # Set bundler parallel jobs count
    if run('sysctl -n hw.ncpu', quiet: true, return_exit_code: true).zero?
      number_of_cores = run('sysctl -n hw.ncpu', quiet: true).strip.to_i - 1
      run("bundle config --global jobs #{number_of_cores}", quiet: true)
    end

    run 'bundle', dir: dir, as: 'bundler'
  end


  # Runs a shell command. Stderr is redirected to Stdout
  # @param [String]  cmd              Command to run
  # @param [String]  dir              Directory to run the command in
  # @param [Boolean] exit_on_failure  Optional (default: true). If true, the script will exited if the command fails
  # @param [Boolean] quiet            Optional (default: true). If true, the command is not printed
  # @param [Boolean] return_exit_code Optional (default: false). If true, the exit code is returned instead of
  #                                   the output
  # @param [String]  as               Optional. Label for the action output (instead of the command)
  # @param [Boolean] bundler          Optional. Run with `bundle exec`?
  # @param [Symbol]  rails_env        Optional. Set RAILS_ENV.
  # @return [String] Stdout or exit code
  public def run(cmd, dir: nil, exit_on_failure: true, quiet: false, return_exit_code: false, as: nil, bundler: false,
                 rails_env: nil)

    # Build complete command
    cmd = build_command(cmd, dir, rails_env, bundler)

    # Run the command and print the output if wished
    output, status = execute_shell_cmd(cmd, quiet, as)

    # Error handling
    if status.nonzero? && return_exit_code == false
      crash "Shell command exited with status code #{status}!", output, command: cmd, exit_on_failure: exit_on_failure
    end

    return_exit_code ? status : output
  end


  # Executes a shell command in the specified dir. Includes benchmarking
  # @param [String] cmd        Command to run
  # @param [String] quiet      Optional. Suppress output
  # @param [String] label      Optional. Label
  # @return [Array] 0 => output, 1 => exit code
  private def execute_shell_cmd(cmd, quiet = false, label = nil)
    label ||= cmd

    # Run the command
    if quiet
      cmd_output = `#{cmd} 2>&1`
      status = $?.to_i
    else
      cmd_output, status = _shell_action(label) { `#{cmd} 2>&1` }
    end

    # Return exit code and output
    [cmd_output, status]
  end


  private def build_command(cmd, dir, rails_env, bundler)
    result = ''
    result += "cd #{dir} && " unless dir.nil?
    result += "RAILS_ENV=#{rails_env} " unless rails_env.nil?
    result += 'bundle exec ' if bundler

    result + cmd
  end
end
