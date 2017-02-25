# Ferrets on Fire

Supercharge your CLI tools. This opinionated, burning ruby gem helps you to write powerful CLI tools of all sizes
without caring about the clutter!

**WARNING: This project is work in progress, use with care.**


## Features

- Super simple and lightweight DSL.
- Beautiful output (especially on OSX).
- Builtin routines for git, bundler, ...
- Framework for system calls: Logging, benchmarking, error handling, crash reporting and more.
- Support CLI switches, options, arguments and commands.
- Supports Logging, colors, progress bars, questions, yes/no and much more.
- Builtin IoC container.
- Ferrets.

## TODO

- Command API
- Code formatting, refactoring, documentation
- Progress bars
- DSL for IoC container
- RSpecs
- CI build


## Installation

```bash
$ gem install ferrets_on_fire
```

or via `Gemfile`:

```ruby
gem 'ferrets_on_fire'
```

Don't forget to run `bundle install`.


## Usage

Loading the Ferrets on Fire framework is made for lazy developers (like me) and requires nearly no code:

```ruby
require '_'
```

This is it. No verbose filenames. No `include`s. No setup.

After that you can already you the fancy ferret DSL:

```ruby
require '_'

# Some output
info 'Running the test suite!'

# Run `bundle exec rspec spec/`
run 'rspec spec/', bundler: true
```


## DSL

This is a complete documentation of the DSL containing all methods, theirs params etc.


### General

- `root()`: Returns the root path of the project, which uses this gem. Requires that the project uses bundler.
- `load_lib()`: Adds the `lib` dir of the project, which uses this gem, to the LOAD_PATH.


### Logging & Interaction

- `banner(string, color: :white, background: :black)`: Prints a banner
    - `string`: The banner.
    - `color`: Optional. Text color.
    - `background`: Optional. Background color.

- `info(msg)`: Prints an information message. Color is white.
    - `msg`: Message to print.

- `action(msg)`: Prints an action message. Color is blue. If a block is given, it turns in a success message after the
  block was yielded. Returns the return value of the block.
    - `msg`: Message to print.

- `warn(msg)`: Prints a warning message. Color is yellow.
    - `msg`: Message to print.

- `success(msg)`: Prints a success message. Color is green.
    - `msg`: Message to print.
    
- `error(msg)`: Prints an error message. Color is red.
    - `msg`: Message to print.
    
- `choose(msg, options, default: nil)`: Let's the user choose out of options. It returns the chosen option.
    - `msg`: Prompt message.
    - `options`: Array of options.
    - `default`: Optional. Default option value.

- `yes_no(msg, default = true)`: Asks the user a simple yes/no question, which can be answered with `y` or `n`. Returns
  true if the user has answered with yes. false for no.
    - `msg`: Prompt message
    - `default`: true = yes is the default, false = no is the default

- `linebreak()`: Prints a linebreak

- `highlight(str)`: Highlights a string for the use with info like: `info("foo #{highlight(bar)}!")`

- `crash(msg, output, command: nil, exit: true)`: Prints a crash report
    - `msg`: Error message.
    - `command`: Optional. Shell command if available.
    - `exit`: Optional. If true the script will exit. 



### Shell commands

- `bundle(dir: nil)`: Runs `bundle install` in the specified dir. Bundler is configured for
  optimal performance.
    - `dir`: Optional. The directory to run in. If empty, the current working dir is used.

- `run(cmd, dir: nil, exit_on_failure: true, quiet: false, return_exit_code: false, as: nil, bundler: false, rails_env: nil)`:
  Executes a shell command. The command will be logged as an action (blue), which turns in a success message after the
  command finished successful. A crash report is generated if the command fails. stderr is redirected to stdout. It
  returns stdout. The command is benchmarked and the time is printed automatically.
    - `cmd`: Command to run.
    - `dir`: Optional. Working dir for the command. If empty, the current working dir is used.
    - `exit_on_failure`: Optional. Exit if the command fails?
    - `quiet`: Optional. Don't log anything if true. 
    - `return_exit_code`: Optional. If true, the exit code is returned rather than the output. 
    - `as`: Optional. Label to use for logging instead of the command.
    - `bundler`: Optional. Run command with `bundle exec`?.
    - `rails_env`: Optional. Set the `RAILS_ENV` variable.


### git

- `update_git_repo(path: nil, desired_branch: nil, skip_update: false)`: Runs a git pull in the specified directory and
  runs the `bin/update` command within that directory, if it exists.
    - `path`: Optional. The directory with the git repo. If not specified, the current working directory is used.
    - `desired_branch`: Optional. Branch that should be checked out - if it's not checked out, a warning is printed.
    - `skip_update`: Optional. Don't run `bin/update` if true.

- `clone_git_repo(remote, target: '', checkout: nil, skip_setup: false)`: Clones a git repository to a local directory
  and runs `bin/setup` if that exists
    - `remote`: The git remote URL.
    - `target`: Optional. Local directory to clone into. If empty, the repo name is used.
    - `checkout`: Optional. Checkout a commit, branch, etc.
    - `skip_setup`: Optional. Don't run `bin/setup` if true.

- `git_checkout(dir, checkout)`: Checks out a specific commit, tag, branch etc.
    - `dir`: Local dir with the repo
    - `checkout`: Ref to checkout

- `find_git_tags(dir)`: Returns all tags in a git repo
    - `dir`: Local dir with the repo

- `get_git_master_ref(dir)`: Returns a Rugged Ref object for the `origin/master` ref 
    - `dir`: Local dir with the repo



## Open Source

MIT Licence. Feel free to contribute.
