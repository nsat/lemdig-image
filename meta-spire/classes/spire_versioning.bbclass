def get_version(path):
    import os
    try:
        with open(os.path.join('/', path, 'VERSION'), 'r') as f:
            return f.read().strip()
    # This hack is required for the LEMDIG2 build process, which allows parametization
    # of the 'air' directory location. We can remove this once hard-coded 'air' paths
    # in meta-spire are changed to parametized paths.
    except IOError:
        print("Failed to get the VERSION file for path: {}. "
              "Ignoring this for now, but may cause a build failure later.".format(path))
        return "0"

def get_version_from_tag(path, tag=None):
    import os
    import shutil

    need_to_delete_branch = False

    if tag is None:
        tag = "master"

    version = "0"

    try:

        tmp = "/tmp/" + tag
        src = path

        if not os.path.isdir(tmp):

            # "git archive" only works if we are at the root of the repo
            workdir = os.getcwd()
            os.chdir("/air")

            #
            # Get the archive at the specified tag
            #
            cmd_fetch = "git archive --format=tar " + tag + ":" + src + " -o " + tmp + ".tar.gz"
            cmd_init = "mkdir -p " + tmp
            cmd_uncompress = "tar -xf " + tmp + ".tar.gz" + " -C " + tmp

            if os.system("git rev-parse --quiet --verify " + tag):
                os.system("git fetch origin --depth 1 " + tag)
                os.system("git tag " + tag + " FETCH_HEAD")
                need_to_delete_branch = True

            if os.system(cmd_fetch + ";" + cmd_init + ";" + cmd_uncompress):
                print("Version file not find for [{}:{}] not found. Exiting.".format(tag, src))

            if need_to_delete_branch:
                os.system("git tag -d " + tag)

            os.chdir(workdir)

        #
        # Read version
        #
        with open(os.path.join(tmp, 'VERSION'), 'r') as f:
            version = f.read().strip()

    except IOError:
        print("Failed to get the VERSION file for path: {}. "
              "Ignoring this for now, but may cause a build failure later.".format(path))

    return version

def get_git_version(repo, path, tag=None, extra=""):
    import os
    import shutil
    import git

    if tag is None:
        tag = "master"

    repo_path = '/tmp/{}-{}-{}-{}'.format(repo, path.replace("/", "_"), tag, extra)

    try:

        if not os.path.isdir(repo_path):

            #
            # Download repo and checkout to desired tag
            #
            r = git.Repo.clone_from('git@{}.github.com:nsat/{}.git'.format(repo, repo), repo_path, depth=1, branch=tag)

        #
        # Read version
        #
        with open(os.path.join(repo_path, path, 'VERSION'), 'r') as f:
            return f.read().strip()

    except IOError:
        print("Failed to get the VERSION file for path: {}/VERSION. "
              "Ignoring this for now, but may cause a build failure later.".format(path))
        return "0"

def get_usw_version(topdir):
    try:
        import os
        import sys
        topdir_split = topdir.split('air/')
        usw_path = os.path.join(topdir_split[0], "air/tools/unified_software")
        sys.path.append(usw_path)
        import usw_versioning
        return usw_versioning.get_version()
    # This hack is required for the LEMDIG2 build process, which cant find the
    # usw_versioning module, nor does it require it.
    except ImportError:
        print("Failed to import usw_versioning. This is expected during lemdig builds "
              "but will fail later in the build if this occurs during the OBC build.")
        return "0"
