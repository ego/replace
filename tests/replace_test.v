import os

const tests_path = 'tests/files'

const content = '
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation Ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation Ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
'

fn test_main() {
	old := 'Ullamco'
	new := 'Wllamco'
	os.write_file('${tests_path}/content.txt', content) or { return }
	result := os.execute_or_panic('${os.quoted_path(@VEXE)} run . ${old} ${new} -d ./${tests_path}')
	assert result.exit_code == 0

	mut new_content := os.read_file('${tests_path}/content.txt') or { return }
	assert !new_content.contains(old)
	assert new_content.contains(new)

	os.rm('${tests_path}/content.txt') or { return }
}
