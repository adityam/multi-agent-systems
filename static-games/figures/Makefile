# Define the shell
SHELL := /bin/bash

# Directory containing PDF files
PDF_DIR := .
# Directory to place SVG files
SVG_DIR := ./svg
# Directory to place scaled SVG files
RSVG_DIR := ./rsvg

# Scaling factor
SCALE := 1.5

PDF_INPUT := $(wildcard $(PDF_DIR)/*.pdf)
SVG_INPUT := $(wildcard $(SVG_DIR)/*.svg)

SVG_OUTPUT :=  $(patsubst $(PDF_DIR)/%.pdf,$(SVG_DIR)/%.svg,$(PDF_INPUT))
RSVG_OUTPUT := $(patsubst $(SVG_DIR)/%.svg,$(RSVG_DIR)/%.svg,$(SVG_INPUT))

# Default target

svg: $(SVG_OUTPUT) 

rsvg: $(RSVG_OUTPUT)

all: svg rsvg

# Rule to convert PDF to SVG
$(SVG_DIR)/%.svg: $(PDF_DIR)/%.pdf
	@mkdir -p $(SVG_DIR)
	mutool convert -F svg -o $@ $<

# Rule to scale up SVG
$(RSVG_DIR)/%.svg: $(SVG_DIR)/%.svg
	@mkdir -p $(RSVG_DIR)
	rsvg-convert -f svg -o $@ -z $(SCALE) $<

# Clean up generated SVG files
clean:
	rm -f $(RSVG_DIR)/*.svg $(SVG_DIR)/*.svg

.PHONY: all clean

