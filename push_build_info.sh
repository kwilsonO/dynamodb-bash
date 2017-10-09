#Fields/Params
JOB_NAME=""
BUILD_NUMBER=""
JOB_ENV=""
JOB_BRANCH=""
BUILD_TIME=""

#usage
usage() { echo "Usage: $0 [-n <JOB NAME|env1-login>] [-v <BUILD VERSION|10>] [-e <JOB ENV|env1>] [-b <BUILD BRANCH|docker_env>] [ -t <BUILD TIME>]" 1>&2; exit 1; }

#counts flags as params
if [ "$#" -ne 10 ]; then
    usage
fi

#Parse params
while getopts "n:v:e:b:t:" o; do
	case "${o}" in
		n) #job name
			JOB_NAME=${OPTARG}
			;;
		v) #build version
			BUILD_NUMBER=${OPTARG}
			;;
		e) #job environment
			JOB_ENV=${OPTARG}
			;;
		b) #build branch
			JOB_BRANCH=${OPTARG}
			;;
		t) #build time
			BUILD_TIME=${OPTARG}
			;;
		*) #not a proper flag/arg
			usage
			;;
	esac
done

#Verify aws cli is installed
command -v aws >/dev/null 2>&1 || { echo >&2 "Please install aws cli.  Aborting."; exit 1; }

echo -e "Storing the following data in dynamodb:\n"
echo -e "JOB_NAME\t${JOB_NAME}"
echo -e "BUILD_NUMBER\t${BUILD_NUMBER}"
echo -e "JOB_ENV\t${JOB_ENV}"
echo -e "JOB_BRANCH\t${JOB_BRANCH}"
echo -e "BUILD_TIME\t${BUILD_TIME}"
