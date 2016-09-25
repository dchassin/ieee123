#
# Makefile
#
# GridLAB-D Realtime Simulator
#

USER = gridlabd
DEST = ~${USER}
HTML = /var/www/html

SOURCE += CA-Bakersfield.tmy2
SOURCE += control.htm
SOURCE += feeder.glm
SOURCE += feeder.htm
SOURCE += geolocation.glm
SOURCE += gridlabd.glm
SOURCE += house.glm
SOURCE += library.glm
SOURCE += loads.glm
SOURCE += meter.htm
SOURCE += model.glm
SOURCE += weather.htm

install: source service html

# source files
source: ${DEST}/CA-Bakersfield.tmy2 ${DEST}/control.htm ${DEST}/geolocation.glm ${DEST}/meter.htm ${DEST}/feeder.glm ${DEST}/gridlabd.glm ${DEST}/library.glm ${DEST}/model.glm ${DEST}/weather.htm ${DEST}/feeder.htm ${DEST}/house.glm ${DEST}/loads.glm

${DEST}/CA-Bakersfield.tmy2: CA-Bakersfield.tmy2
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/control.htm: control.htm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/feeder.glm: feeder.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/feeder.htm: feeder.htm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/geolocation.glm: geolocation.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/gridlabd.glm: gridlabd.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/house.glm: house.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/library.glm: library.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/loads.glm: loads.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/meter.htm: meter.htm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/model.glm: model.glm
	install -o ${USER} -g ${USER} -m 644 $< $@

${DEST}/weather.htm: weather.htm
	install -o ${USER} -g ${USER} -m 644 $< $@

# service files
service: /etc/init.d/gridlabd /etc/gridlabd.conf

/etc/init.d/gridlabd: service/gridlabd
	install -o ${USER} -g ${USER} -m 755 $< $@	

/etc/gridlabd.conf: service/gridlabd.conf
	install -o ${USER} -g ${USER} -m 644 $< $@

# HTML files
html: ${HTML}/config.php ${HTML}/graph.html ${HTML}/graph.php ${HTML}/graphtool.php ${HTML}/index.html ${HTML}/phpgraphlib.php

${HTML}/config.php: html/config.php
	install -o apache -g apache -m 644 $< $@

${HTML}/graph.html: html/graph.html
	install -o apache -g apache -m 644 $< $@

${HTML}/graph.php: html/graph.php
	install -o apache -g apache -m 644 $< $@

${HTML}/graphtool.php: html/graphtool.php
	install -o apache -g apache -m 644 $< $@

${HTML}/index.html: html/index.html
	install -o apache -g apache -m 644 $< $@

${HTML}/phpgraphlib.php: html/phpgraphlib.php
	install -o apache -g apache -m 644 $< $@
