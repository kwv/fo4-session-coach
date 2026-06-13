# Session Coach — build from WSL
#
# PapyrusCompiler.exe is a Windows executable that requires Windows-style paths.
# We delegate to compile.bat running under cmd.exe rather than reimplementing
# the path logic here.
#
# Requires tools/paths.local.bat (copy from tools/paths.example.bat).

COMPILE_BAT := $(shell wslpath -w $(CURDIR)/tools/compile.bat)
RUN_BAT     := $(shell wslpath -w $(CURDIR)/tools/run.bat)

.PHONY: build run

build:
	cmd.exe /c "$(COMPILE_BAT)"

run:
	cmd.exe /c "$(RUN_BAT)"
