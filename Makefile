# Makefile
# Copyright (C) 2016, Stanford University
# Author: dchassin@slac.stanford.edu
#
# GridLAB-D Realtime Simulator
#

USER = gridlabd
DST = ~$(USER)
DOC = /var/www/html
ETC = /etc
INI = /etc/init.d
BIN = ~$(USER)/bin

#
# Source files
#
SRC_TMY = $(shell ls *.tmy?)
SRC_GLM = $(shell ls *.glm)
SRC_HTM = $(shell ls *.htm)
SRC_CSV = $(shell ls *.csv)
SRC_TST = $(shell ls switchtest/*.glm)
SRC_ETC = $(shell ls etc/*)
SRC_INI = $(shell ls ini/*)
SRC_BIN = $(shell ls bin/*)
SRC_DOC = $(shell ls html/*)

#
# Destination files
#
DST_TMY = $(addprefix $(DST)/,$(SRC_TMY))
DST_GLM = $(addprefix $(DST)/,$(SRC_GLM))
DST_HTM = $(addprefix $(DST)/,$(SRC_HTM))
DST_CSV = $(addprefix $(DST)/,$(SRC_CSV))
DST_TST = $(addprefix $(DST)/,$(SRC_TST))
DST_DOC = $(subst html/,$(DOC)/,$(SRC_DOC))
DST_ETC = $(subst etc/,$(ETC)/,$(SRC_ETC))
DST_INI = $(subst ini/,$(INI)/,$(SRC_INI))
DST_BIN = $(subst bin/,$(BIN)/,$(SRC_BIN))

install: source service html
	git log -n 1 --date=iso | grep '^Date: ' | sed 's/Date:   //' >$(DST)/.update-info

# service files
service: $(DST_ETC) $(DST_INI) $(DST_BIN) $(DST_CSV)

$(INI)/%: $(SRC_INI)
	install -o root -g wheel -m 755 $< $@	

$(ETC)/%: $(SRC_ETC)
	install -o root -g wheel -m 644 $< $@

$(BIN)/%: $(SRC_BIN)
	install -o root -g wheel -m 755 $< $@

# HTML files
html: $(DST_DOC)

$(DOC)/%: html/%
	install -o apache -g apache -m 644 $< $@

# source files
source: $(DST_TMY) $(DST_GLM) $(DST_HTM) $(DST_CSV) $(DST_TST) $(DST)/config.glm $(DST)/run_switchtests

$(DST)/config.glm: $(DST)/config-template.glm
	#
	# WARNING: $@ is missing or outdated ($< is newer)
	#

$(DST)/run_switchtests: run_switchtests
	install -o $(USER) -g $(USER) -m 755 $< $@

$(DST)/%: %
	install -o $(USER) -g $(USER) -m 644 $< $@

