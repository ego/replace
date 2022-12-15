module main

import os
import flag
import v.vmod

fn main() {
	mod := vmod.decode(@VMOD_FILE) or { panic('Error decoding v.mod') }

	mut fp := flag.new_flag_parser(os.args)

	fp.application('replace')
	fp.version(mod.version)
	fp.description('CLI application that find and replace string in files.\n${mod.author}.\n${mod.repo_url}')
	fp.skip_executable()

	mut old := fp.string('old', `o`, '', 'String to find.')
	mut new := fp.string('new', `n`, '', 'String to replace.')
	search_path := fp.string('dir', `d`, '.', 'Search path.')

	fp.usage_example('replace -o old-text -n new-text -d ./search_path\nreplace old-text new-text')
	fp.limit_free_args(0, 2)!

	additional_args := fp.finalize() or {
		println('All parameters should be provided.')
		println(fp.usage())
		return
	}

	if additional_args.len > 0 {
		old = additional_args[0]
		new = additional_args[1]
	}

	mut files := []string{}
	os.walk_with_context(search_path, &files, fn (mut fs []string, f string) {
		if f in ['.', '..'] {
			return
		}

		if f.contains('/.git/') {
			return
		}

		if os.file_name(f).starts_with('.') {
			return
		}

		if os.is_executable(f) || !os.is_readable(f) {
			return
		}

		if os.is_file(f) {
			fs << f
		}
	})

	println('Repace ${old} -> ${new}')

	if files.len > 0 {
		println('Found strings in files count: ${files.len}')
	}

	for path in files {
		mut content := os.read_file(path) or { return }
		if content.contains(old) {
			content = content.replace(old, new)
			os.write_file(path, content) or { return }
			println('Replace content in file: ${path}')
		}

		if os.file_name(path).contains(old) {
			content = os.file_name(path).replace(old, new)
			new_path := path.trim_string_right(os.file_name(path)) +
				os.file_name(path).replace(old, new)
			os.mv(path, new_path) or { return }
			println('Rename file: ${path} to ${new_path}')
		}
	}
}
