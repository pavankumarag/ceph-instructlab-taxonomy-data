# Testing notes

## build-integration-branch

### Setup

1.  Create a github token at <https://github.com/settings/tokens> and
    put it in `~/.github_token`. Note that only the `public_repo` under
    the `repo` section needs to be checked.

2.  Create a ceph repo label [wip-yourname-testing]{.title-ref} if you
    don\'t already have one at <https://github.com/ceph/ceph/labels>.

3.  Create the `ci` remote:

        git remote add ci git@github.com:ceph/ceph-ci

### Using

1.  Tag some subset of [needs-qa]{.title-ref} commits with your label
    (usually [wip-yourname-testing]{.title-ref}).

2.  Create the integration branch:

        git checkout master
        git pull
        ../src/script/build-integration-branch wip-yourname-testing

3.  Smoke test:

        ./run-make-check.sh

4.  Push to ceph-ci:

        git push ci $(git rev-parse --abbrev-ref HEAD)
