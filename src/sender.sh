#!/usr/bin/env bash

DEBUG=${DEBUG:-0}
SENDMAIL='/usr/sbin/sendmail'

cd "$(dirname "$0")"

STATDIR="$(readlink -f .)/.stats"
mkdir -vp "${STATDIR}"


if [ "$#" -gt 0 ]; then
	pushd "$1" >/dev/null
	for f in $(find ./ -maxdepth 1 -type f); do
		f=$(echo "${f}" | cut -c3-)
		WEEKDAY=$(echo "${f}" | cut -d_ -f1)
		HOUR=$(echo "${f}" | cut -d_ -f2)
		MINUTE=$(echo "${f}" | cut -d_ -f3)

		STATFILE="${STATDIR}/$(readlink -f "${f}" | sed 's/_/__/g' | sed 's-/-_-g')"
		
		if [ -r "${STATFILE}" ]; then
			LASTRUN="$(cat "${STATFILE}")"
		fi
		LASTRUN="${LASTRUN:-0}"
		NOW="$(date +%s)"
		SHOULDRUN="$(date -d @"${NOW}" +%s)"
		
		if [ ${DEBUG} -ne 0 ]; then
			echo f "$(readlink -f "${f}" | sed 's/_/__/g' | sed 's-/-_-g')"
			echo W ${WEEKDAY}
			echo H ${HOUR}
			echo M ${MINUTE}
			echo LR ${LASTRUN}
			echo NOW ${NOW}
			echo SR ${SHOULDRUN} #D $(date -d @${SHOULDRUN})
			echo D $(expr ${NOW} - ${LASTRUN})
		fi

		if [ $(date -d @${NOW} +%w) -eq "${WEEKDAY}" -a  \
		     $(date -d @${NOW} +%H) -ge "${HOUR}" -a     \
		     $(date -d @${NOW} +%M) -ge "${MINUTE}" -a   \
		     $(expr ${NOW} - ${LASTRUN}) -ge "$(expr 60 \* 60 \* 23)" \
		]; then
			echo "running ${f}"
			echo "${NOW}" > ${STATFILE}
			# introduce up to 21 minutes of randomness to send time (only in the past)
			export DATE=$(date -d @$(expr ${NOW} - 60 \* $(shuf -i 0-20 -n1) - $(shuf -i 0-59 -n1)))
			EMAIL=$(source ./${f})
			if [ ${DEBUG} -ne 0 ]; then
				echo EMAIL=
				echo "${EMAIL}"
			else
				echo "${EMAIL}" | ${SENDMAIL} -t -i
			fi
		fi		
	done
	popd >/dev/null
else
	find ./tasks/ -maxdepth 1 -type d ! -path ./tasks/ | xargs -n1 "$0"
fi
