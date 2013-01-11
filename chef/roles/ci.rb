name "ci"
description "Base role for CI machine"
run_list "recipe[jenkins]", "role[baserole]"
