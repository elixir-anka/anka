.PHONY: test
test:
	MIX_ENV=test mix test

docs:
	MIX_ENV=docs mix docs


docs.hint:
	MIX_ENV=docs mix inch
