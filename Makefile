#
# Makefile
#
# GridLAB-D Realtime Simulator
#

USER = gridlabd
TARGET = ~${USER}

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

install: source service 

source: 
	install -o ${USER} -g ${USER} -m 644 ${SOURCE} ${TARGET}

service: /etc/init.d/gridlabd /etc/gridlabd.conf

/etc/init.d/gridlabd: service/gridlabd
	install -o ${USER} -g ${USER} -m 755 $< $@	

/etc/gridlabd.conf: service/gridlabd.conf
	install -o ${USER} -g ${USER} -m 644 $< $@

