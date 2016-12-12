# cron-docker
Example repo for running cronjobs inside a Docker container.

docker build -t cron-docker .


docker run --name cron-mongo -v /Users/brandon/DockerPrj/cron-docker/datadir:/data/db -p 27017:27017 -it --rm cron-docker

mongo localhost:27017/exampledb

docker exec -it cron-mongo tail /var/log/cron.log


Post gcloud:

http://stackoverflow.com/questions/27439326/how-to-properly-run-gsutil-from-crontab
docker run --name cron-mongo -v /Users/brandon/DockerPrj/cron-docker/config:/etc/gsutil/auth -v /Users/brandon/DockerPrj/cron-docker/datadir:/data/db -p 27017:27017 -it --rm cron-docker


Updated:

To authenticate with a Google Cloud Service Account:
1. Follow the instructions from [gsutil-docker](https://github.com/brisberg/gsutil-docker) to create a config directory.
2. Copy that `config` directory to your project here.
3. Run this image with the config included as a volume:
   - docker run --name cron-mongo -v /Users/brandon/DockerPrj/cron-docker/config:/etc/gsutil/auth -v /Users/brandon/DockerPrj/cron-docker/datadir:/data/db -p 27017:27017 -it --rm cron-docker
