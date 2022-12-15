#!/usr/bin/env -S v

fn sh(cmd string) {
	println('❯ ${cmd}')
	print(execute_or_exit(cmd).output)
}

sh('cp replace /usr/local/bin')
