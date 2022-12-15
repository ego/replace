#!/usr/bin/env -S v

import v.vmod
import os

const git_repo = 'git@github.com:ego/replace.git'
const mainline_branch = 'main'
const semantic_version = 'patch'  // v bump --help

fn cli_version() string {
    content := os.read_file('v.mod') or { panic('Error read v.mod') }
    mod := vmod.decode(content) or { panic('Error decoding v.mod') }
    return mod.version
}

fn sh(cmd string) {
    println('❯ ${cmd}')
    print(execute_or_exit(cmd).output)
}

fn bump_and_release() {
    sh('git checkout $mainline_branch')
    sh('git pull origin $mainline_branch')
    sh('git merge --no-ff $mainline_branch')
    sh('v bump --$semantic_version')
    new_tag := cli_version()
    sh('git tag $new_tag')
    sh('git push --force-with-lease --atomic origin $mainline_branch $new_tag')
    println('❯ Release $new_tag done.')
}

bump_and_release()
