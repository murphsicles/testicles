# testicles — build and test
ZETAC ?= /home/zeta/.openclaw/workspace/zeta/bin/zetac

.PHONY: all test clean

all: test

test:
	$(ZETAC) src/testicles.z

clean:
	rm -f *.o *.out
