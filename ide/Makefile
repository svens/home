project = $(notdir $(PWD))


# Variables that select action if defined {{{1
#

# if has value, edit module
edit :=


# Variable based action selection {{{1
#


ifneq ($(edit),)
all: .edit
else
all: .build
endif


# tmux "IDE" {{{1
#

ide-edit:
	tmux has-session -t "$(project)/edit" >/dev/null 2>&1 \
	  && ( tmux detach-client -s "$(project)/edit" || true ) \
	  || tmux new-session -s "$(project)/edit" -n main -d
	tmux attach-session -t "$(project)/edit"

ide-work:
	tmux has-session -t "$(project)/work" >/dev/null 2>&1 \
	  && ( tmux detach-client -s "$(project)/work" || true ) \
	  || ( tmux new-session -s "$(project)/work" -n main -d \; \
	    new-window -n gcc-debug -c .work/gcc-debug \; \
	    new-window -n gcc-release -c .work/gcc-release \; \
	    new-window -n clang-debug -c .work/clang-debug \; \
	    new-window -n clang-release -c .work/clang-release \; \
	    new-window -n infra -c .work/infra \; \
	    select-window -t "$(project)/work:main" \; \
	  )
	tmux attach-session -t "$(project)/work"


# Generic editing target {{{1
#


.edit:
	$(EDITOR) $(EDITORFLAGS) $(edit)/list.cmake $$(grep "^[[:space:]]*$(edit)/" $(edit)/list.cmake)

tags:
	find . -name '*pp' -not -path './.work/*' > .work/sources.txt
	cscope -bckR -I. -I.work/clang-debug/$(project) -f.work/cscope.out -i.work/sources.txt
	ctags -R -f .work/tags --excmd=pattern --file-scope=no --if0 --tag-relative -L.work/sources.txt


# Building targets {{{1
#


.cmake:
	printf "\033[1;36m$(build)\033[m\n"
	cmake --build .work/$(build)

gcc-debug:
	$(MAKE) .cmake build=$@
.build:: gcc-debug

gcc-release:
	$(MAKE) .cmake build=$@
.build:: gcc-release

clang-debug:
	$(MAKE) .cmake build=$@
.build:: clang-debug

clang-release:
	$(MAKE) .cmake build=$@
.build:: clang-release


# Testing targets {{{1
#


.ctest:
	printf "\033[1;36m$(build)\033[m\n"
	cd .work/$(build) && ctest --output-on-failure

gcc-debug-test:
	$(MAKE) .ctest build=gcc-debug
test:: gcc-debug-test

gcc-release-test:
	$(MAKE) .ctest build=gcc-release
test:: gcc-release-test

clang-debug-test:
	$(MAKE) .ctest build=clang-debug
test:: clang-debug-test

clang-release-test:
	$(MAKE) .ctest build=clang-release
test:: clang-release-test


# Coverage target {{{1
#

gen-cov:
	ninja -C .work/infra gen-cov
	open .work/infra/cov/index.html


# Documentation target {{{1
#

gen-doc:
	ninja -C .work/infra gen-doc
	open .work/infra/docs/index.html


# Buildsystem(s) initialisation {{{1
#


.init_cmake:
	printf "\033[1;36m$(config)\033[m\n"
	mkdir -p .work/$(config) \
	  && cd .work/$(config) \
	  && cmake ../.. -G Ninja $(CMAKE_OPTS)

.init_cmake_gcc_debug:
	$(MAKE) .init_cmake config=gcc-debug CXX=g++-7 CC=gcc-7 CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_cmake_gcc_debug

.init_cmake_gcc_release:
	$(MAKE) .init_cmake config=gcc-release CXX=g++-7 CC=gcc-7 CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release"
init:: .init_cmake_gcc_release

.init_cmake_clang_debug:
	$(MAKE) .init_cmake config=clang-debug CXX=clang++ CC=clang CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_cmake_clang_debug

.init_cmake_clang_release:
	$(MAKE) .init_cmake config=clang-release CXX=clang++ CC=clang CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release"
init:: .init_cmake_clang_release

.init_cmake_infra:
	$(MAKE) .init_cmake config=infra CXX=g++-7 CC=gcc-7 GCOV=gcov-7 CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Coverage"
init:: .init_cmake_infra


.SILENT:
