#!/bin/bash
#

FILE=$1
MEMTOTAL=MemTotal
MEMFREE=MemFree
MEMAVAIL=MemAvailable
CACHED=Cached
ACTIVE=Active
INACTIVE=Inactive
ANONPAGES=AnonPages
MAPPED=Mapped
SHMEM=Shmem

if [ -z ${FILE} ]; then
	echo "File is not exist"	
	exit 256
fi

title="##Time ${MEMTOTAL} ${MEMFREE} ${MEMAVAIL} ${CACHED} ${ACTIVE} ${INACTIVE} ${ANONPAGES} ${MAPPED} ${SHMEM}"

echo ${title} > ${FILE}


while true
do
	meminfo=`cat /proc/meminfo | sed -n "/^${MEMTOTAL}:/p;/^${MEMFREE}:/p;/^${MEMAVAIL}:/p;/^${CACHED}:/p;/^${ACTIVE}:/p;/^${INACTIVE}:/p;/^${ANONPAGES}:/p;/^${MAPPED}:/p;/^${SHMEM}:/p"`
	echo ${meminfo}
	content=`date +%H:%M:%S`" "`echo ${meminfo} | sed "s/${MEMTOTAL}: //g" | sed "s/${MEMFREE}: //g" | sed "s/${MEMAVAIL}: //g" | sed "s/${CACHED}: //g" | sed "s/${ACTIVE}: //g" | sed "s/${INACTIVE}: //g" | sed "s/${ANONPAGES}: //g" | sed "s/${MAPPED}: //g" | sed "s/${SHMEM}: //g" | sed 's/kB//g'`

	echo ${content} >> ${FILE}
	sleep 2 
done

exit 0
