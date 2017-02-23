module FerretsOnFire::DSL::Git
  # Updates the git repository in the current directory and runs bin/update
  # @param [String] path The directory to use, default is the current one
  public def update_repo(path: nil, desired_branch: nil)
    run 'git pull -r --autostash', dir: path, as: 'git pull'

    # get current branch name
    if desired_branch
      current_branch = run('git branch | grep \*', dir: path, quiet: true).sub('*', '').strip

      unless current_branch == desired_branch
        warn "WARNING: Current branch is not #{desired_branch} (it's #{current_branch})"
      end
    end

    run('bin/update', dir: path, as: 'bin/update', bundler: true) if File.exists?('bin/update')
  end


  public def clone_repo(remote, target: '', desired_branch: 'develop')
    run "git clone #{remote} #{target}", as: 'clone'
    run "git checkout #{desired_branch}", as: "checkout #{desired_branch}", dir: target
    run('bin/setup', dir: target, as: 'bin/setup', bundler: true) if File.exists?('bin/setup')
  end
end
