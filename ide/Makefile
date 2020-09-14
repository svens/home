link := $(shell readlink project 2>/dev/null || echo $$?)
ifeq ($(link),1)
  $(error Create symlink 'project' to project root directory)
endif
project_root := $(abspath $(link))
project := $(notdir $(project_root))


all: build


# Toolchain {{{1


-include toolchain.mk
CLANG_CC ?= clang
CLANG_CXX ?= clang++
GCC_CC ?= gcc
GCC_CXX ?= g++
GCC_COV ?= gcov


# Workspace {{{1


ide:
	tmux has-session -t "$(project)/ide" >/dev/null 2>&1 \
	  && ( tmux detach-client -s "$(project)/ide" || true ) \
	  || ( \
	    tmux new-session -s "$(project)/ide" -n main -c $(project_root) -d \; \
	    new-window -n work -c . \; \
	    select-window -t "$(project)/ide:main" \; \
	  )
	tmux attach-session -t "$(project)/ide"


work:
	tmux has-session -t "$(project)/work" >/dev/null 2>&1 \
	  && ( tmux detach-client -s "$(project)/work" || true ) \
	  || ( \
	    tmux new-session -s "$(project)/work" -n main -c $(project_root) -d \; \
	    new-window -n work -c . \; \
	    new-window -n gcc-debug -c gcc-debug \; \
	    new-window -n gcc-release -c gcc-release \; \
	    new-window -n clang-debug -c clang-debug \; \
	    new-window -n clang-release -c clang-release \; \
	    new-window -n cov -c cov \; \
	    select-window -t "$(project)/work:main" \; \
	  )
	tmux attach-session -t "$(project)/work"


# Init {{{1


.init:
	printf "\033[1;36m$(config)\033[m (CC=$(CC) CXX=$(CXX) COV=$(COV))\n"
	mkdir -p $(config) \
	  && cd $(config) \
	  && cmake $(project_root) -G Ninja $(CMAKE_OPTS)

.init_gcc_debug:
	$(MAKE) .init config=gcc-debug CXX=$(GCC_CXX) CC=$(GCC_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_gcc_debug

.init_gcc_release:
	$(MAKE) .init config=gcc-release CXX=$(GCC_CXX) CC=$(GCC_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release -D$(project)_benchmarks=yes"
init:: .init_gcc_release

.init_clang_debug:
	$(MAKE) .init config=clang-debug CXX=$(CLANG_CXX) CC=$(CLANG_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Debug"
init:: .init_clang_debug

.init_clang_release:
	$(MAKE) .init config=clang-release CXX=$(CLANG_CXX) CC=$(CLANG_CC) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release -D$(project)_benchmarks=yes"
init:: .init_clang_release

.init_cov:
	$(MAKE) .init config=cov CXX=$(GCC_CXX) CC=$(GCC_CC) COV=$(GCC_COV) CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Coverage -D$(project)_docs=yes"
init:: .init_cov


# Nuke {{{1

nuke:
	rm -rf clang-debug clang-release gcc-debug gcc-release cov


# Build {{{1


.build:
	printf "\033[1;36m$(config)\033[m\n"
	cmake --build $(config)

.build_gcc_debug:
	$(MAKE) .build config=gcc-debug
build:: .build_gcc_debug

.build_gcc_release:
	$(MAKE) .build config=gcc-release
build:: .build_gcc_release

.build_clang_debug:
	$(MAKE) .build config=clang-debug
build:: .build_clang_debug

.build_clang_release:
	$(MAKE) .build config=clang-release
build:: .build_clang_release


# Test {{{1


.test:
	printf "\033[1;36m$(config)\033[m\n"
	cmake --build $(config) --target test

.test_gcc_debug:
	$(MAKE) .test config=gcc-debug
test:: .test_gcc_debug

.test_gcc_release:
	$(MAKE) .test config=gcc-release
test:: .test_gcc_release

.test_clang_debug:
	$(MAKE) .test config=clang-debug
test:: .test_clang_debug

.test_clang_release:
	$(MAKE) .test config=clang-release
test:: .test_clang_release


# Clean {{{1


.clean:
	printf "\033[1;36m$(config)\033[m\n"
	cmake --build $(config) --target clean

.clean_gcc_debug:
	$(MAKE) .clean config=gcc-debug
clean:: .clean_gcc_debug

.clean_gcc_release:
	$(MAKE) .clean config=gcc-release
clean:: .clean_gcc_release

.clean_clang_debug:
	$(MAKE) .clean config=clang-debug
clean:: .clean_clang_debug

.clean_clang_release:
	$(MAKE) .clean config=clang-release
clean:: .clean_clang_release


# Coverage {{{1


gen-cov:
	ninja -C cov $(project)-cov
	open cov/cov/index.html


# }}}1


.SILENT:
