UNITTEST_BUILD_DIRECTORY := build_unittest
CXXTEST_FIND_ROOT ?=
CXXTEST_FIND_PATTERN := $(CXXTEST_FIND_ROOT) -name 'Test_*.h'
PYTEST_FIND_ROOT ?=
PYTEST_FIND_PATTERN := $(PYTEST_FIND_ROOT) -name 'test_*.py'
ENFORCE_COVERAGE_FIND_ROOT_CPP ?=
ENFORCE_COVERAGE_FIND_EXCLUDE_REGEXES := '.*\<$(UNITTEST_BUILD_DIRECTORY)\>/.*' '.*\<tests\>.*' '.*\<build\>.*'
ENFORCE_COVERAGE_FIND_PATTERN_CPP := $(ENFORCE_COVERAGE_FIND_ROOT_CPP) '(' -name '*.cpp' -or -name '*.h' ')' $(patsubst %,-and -not -regex %,$(ENFORCE_COVERAGE_FIND_EXCLUDE_REGEXES))

VOODOO_MIRROR_TREE ?= $(UNITTEST_BUILD_DIRECTORY)/voodoo

__REMOVE_DOT_SLASH_PREFIX = | sed 's@^\./@@'
CXXTEST_TEST_FILES = $(shell find $(CXXTEST_FIND_PATTERN) $(__REMOVE_DOT_SLASH_PREFIX))
CXXTEST_GENERATED = $(patsubst %.h,$(UNITTEST_BUILD_DIRECTORY)/%.cxx,$(subst /,_,$(CXXTEST_TEST_FILES)))
CXXTEST_BINARIES = $(patsubst %.cxx,%.bin,$(CXXTEST_GENERATED))

ifeq ($(V),1)
  Q =
else
  Q = @
endif
