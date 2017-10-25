project = $(notdir $(PWD))


# Toolchain selection {{{1
#


CLANG_CC := clang
CLANG_CXX := clang++
GCC_CC := gcc-7
GCC_CXX := g++-7
GCC_GCOV := gcov-7


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

ide:
	tmux has-session -t "$(project)/edit" >/dev/null 2>&1 \
	  && ( tmux detach-client -s "$(project)/edit" || true ) \
	  || tmux new-session -s "$(project)/edit" -n main -d
	tmux attach-session -t "$(project)/edit"

work:
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


.make:
	printf "\033[1;36m$(build)\033[m\n"
	cmake --build .work/$(build)

gcc-debug:
	$(MAKE) .make build=$@
.build:: gcc-debug

gcc-release:
	$(MAKE) .make build=$@
.build:: gcc-release

clang-debug:
	$(MAKE) .make build=$@
.build:: clang-debug

clang-release:
	$(MAKE) .make build=$@
.build:: clang-release


# Testing targets {{{1
#


.test:
	printf "\033[1;36m$(build)\033[m\n"
	cd .work/$(build) && ctest --output-on-failure

test-gcc-debug:
	$(MAKE) .test build=gcc-debug
test:: test-gcc-debug

test-gcc-release:
	$(MAKE) .test build=gcc-release
test:: test-gcc-release

test-clang-debug:
	$(MAKE) .test build=clang-debug
test:: test-clang-debug

test-clang-release:
	$(MAKE) .test build=clang-release
test:: test-clang-release


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


.init:
	printf "\033[1;36m$(config)\033[m\n"
	mkdir -p .work/$(config) \
	  && cd .work/$(config) \
	  && cmake ../.. -G Ninja $(CMAKE_OPTS)

.init_gcc_debug:
	$(MAKE) .init config=gcc-debug CXX=$(GCC_CXX) CC=$(GCC_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_gcc_debug

.init_gcc_release:
	$(MAKE) .init config=gcc-release CXX=$(GCC_CXX) CC=$(GCC_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release"
init:: .init_gcc_release

.init_clang_debug:
	$(MAKE) .init config=clang-debug CXX=$(CLANG_CXX) CC=$(CLANG_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_clang_debug

.init_clang_release:
	$(MAKE) .init config=clang-release CXX=$(CLANG_CXX) CC=$(CLANG_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release"
init:: .init_clang_release

.init_infra:
	$(MAKE) .init config=infra CXX=$(GCC_CXX) CC=$(GCC_CC) GCOV=$(GCC_GCOV) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Coverage -DDOCS=yes"
init:: .init_infra


.SILENT:
