def get_project_from_tag(path, tag=None):
    import os

    need_to_delete_branch = False

    #
    # This function needs to be called from do_unpack_append() as Yocto
    # create ${S} directory during this step
    #

    # "git archive" only works if we are at the root of the repo
    workdir = os.getcwd()
    os.chdir("/air")

    tmp = workdir + "/archive/" + tag

    if os.system("git rev-parse --quiet --verify " + tag):
        os.system("git fetch origin --depth 1 " + tag)
        os.system("git tag " + tag + " FETCH_HEAD")
        need_to_delete_branch = True

    os.system("git archive --format=tar " + tag + ":" + path + " -o " + tmp + ".tar.gz")
    os.system("mkdir -p " + tmp)
    os.system("tar -xf " + tmp + ".tar.gz -C " + tmp)

    if need_to_delete_branch:
        os.system("git tag -d " + tag)

    os.chdir(workdir)
