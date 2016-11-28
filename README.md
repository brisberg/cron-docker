# cron-docker
Example repo for running cronjobs inside a Docker container.

docker build -t cron-docker .


docker run --name cron-mongo -v /Users/brandon/DockerPrj/cron-docker/datadir:/data/db -p 27017:27017 -it --rm cron-docker

mongo localhost:27017/exampledb

docker exec -it cron-mongo tail /var/log/cron.log


Post gcloud:

http://stackoverflow.com/questions/27439326/how-to-properly-run-gsutil-from-crontab
docker run --name cron-mongo -v /Users/brandon/DockerPrj/cron-docker/config:/.config -v /Users/brandon/DockerPrj/cron-docker/datadir:/data/db -p 27017:27017 -it --rm cron-docker
