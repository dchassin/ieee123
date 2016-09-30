#
# Makefile
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
DST_DOC = $(subst html/,$(DOC)/,$(SRC_DOC))
DST_ETC = $(subst etc/,$(ETC)/,$(SRC_ETC))
DST_INI = $(subst ini/,$(INI)/,$(SRC_INI))
DST_BIN = $(subst bin/,$(BIN)/,$(SRC_BIN))

install: source service html

# source files
source: $(DST_TMY) $(DST_GLM)

$(DST)/%: %
	install -o $(USER) -g $(USER) -m 644 $< $@

# service files
service: $(DST_ETC) $(DST_INI) $(DST_BIN)

$(INI)/%: $(SRC_INI)
	install -o root -g wheel -m 755 $< $@	

$(ETC)/%: $(SRC_ETC)
	install -o root -g wheel -m 644 $< $@

$(BIN)/%: $(SRC_BIN)
	install -o root -g wheel -m 755 $< $@

# HTML files
html: $(DST_DOC)

$(DOC)/%: %
	install -o apache -g apache -m 644 $< $@

