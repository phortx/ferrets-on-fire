module FerretsOnFire::DSL::GitDSL
  # Updates the git repository in the current directory and runs bin/update
  # @param [String] path The directory to use, default is the current one
  public def update_git_repo(path: nil, desired_branch: nil, skip_update: false)
    run 'git pull -r --autostash', dir: path, as: 'git pull'

    # get current branch name
    if desired_branch
      current_branch = run('git branch | grep \*', dir: path, quiet: true).sub('*', '').strip

      unless current_branch == desired_branch
        warn "WARNING: Current branch is not #{desired_branch} (it's #{current_branch})"
      end
    end

    run('bin/update', dir: path, as: 'bin/update', bundler: true) if !skip_update && File.exists?('bin/update')
  end


  public def clone_git_repo(remote, target: '', checkout: nil, skip_setup: false)
    run "git clone #{remote} #{target}", as: 'clone git repo'
    run "git checkout #{checkout}", as: "checkout #{checkout}", dir: target unless checkout.nil?
    run('bin/setup', dir: target, as: 'bin/setup', bundler: true) if !skip_setup && File.exists?('bin/setup')
  end

  private def _git_setup(dir)
    require 'rugged'
    Rugged::Repository.new(dir)
  end


  public def git_checkout(dir, checkout)
    repo = _git_setup(dir)
    repo.checkout checkout, strategy: :force
  end

  public def find_git_tags(dir)
    repo = _git_setup(dir)

    # Find all tags
    tags = []
    repo.references.each('refs/tags/*') { |ref| tags << ref }
    tags
  end

  public def find_git_branches(dir)
    repo = _git_setup(dir)

    # Find all tags
    branches = []
    repo.references.each('refs/heads/*') { |ref| branches << ref }
    branches
  end

  public def get_git_master_ref(dir)
    repo = _git_setup(dir)
    repo.ref('refs/remotes/origin/master')
  end
end
