config ?= debug

ifdef config
  ifeq (,$(filter $(config),debug release))
    $(error Unknown configuration "$(config)")
  endif
endif

ifeq ($(config),debug)
  PONYC-FLAGS += --debug
endif

NAME = jingwei
BUILDDIR = /dev/shm/$(NAME)
TARGET = $(BUILDDIR)/$(config)/test
BUILDSCRIPTS = corral.json lock.json
SRCDIR = $(NAME)
SRCS = $(wildcard $(SRCDIR)/*.pony)

PONYC ?= ponyc
COMPILE-WITH := corral run -- $(PONYC)
PONYC-FLAGS += -V1 -o $(BUILDDIR)/$(config)

DEPS =

all: $(TARGET)

$(TARGET): $(SRCS) $(DEPS)
	$(COMPILE-WITH) $(PONYC-FLAGS) --bin-name=test $(NAME)

$(DEPS): corral.json
	corral fetch

prebuild:
ifeq "$(wildcard $(BUILDDIR))" ""
	@mkdir -p $(BUILDDIR)/$(config)
endif

clean:
	rm -rf $(BUILDDIR)

.PHONY: all clean prebuild
