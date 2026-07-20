.PHONY: install build test fmt fmt-check clean

FOUNDRY ?= forge

install:
	rm -rf lib/forge-std lib/openzeppelin-contracts
	$(FOUNDRY) install foundry-rs/forge-std@v1.9.6 --no-git
	$(FOUNDRY) install OpenZeppelin/openzeppelin-contracts@v5.0.2 --no-git
	@test -f lib/pledge-oracle/src/interfaces/IOracle.sol || (echo "Run: git submodule update --init lib/pledge-oracle" && exit 1)

build:
	$(FOUNDRY) build --sizes

test:
	$(FOUNDRY) test -vv

fmt:
	$(FOUNDRY) fmt

fmt-check:
	$(FOUNDRY) fmt --check

clean:
	rm -rf out cache broadcast
