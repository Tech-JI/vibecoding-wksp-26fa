PDF_ENGINE ?= tectonic
SOURCE ?= slides/workshop.md
OUTPUT ?= output/pdf/workshop.pdf

.PHONY: build agent
build:
	@mkdir -p $(dir $(OUTPUT))
	pandoc $(SOURCE) --standalone --to=beamer --pdf-engine=$(PDF_ENGINE) --slide-level=2 --syntax-highlighting=tango -o $(OUTPUT)

agent:
	$(MAKE) build SOURCE=slides/agent-tutorial.md OUTPUT=output/pdf/agent-tutorial.pdf
