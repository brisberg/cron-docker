FROM mongo:3.0
MAINTAINER Brandon Risberg

#Enabling GCS CLI (from https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/Dockerfile)
RUN \
  apt-get update && \
  apt-get install -y -qq --no-install-recommends \
    ca-certificates \
    cron \
    python \
    unzip \
    wget && \
  apt-get clean

# Install gsutil
ENV HOME /
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN \
  wget https://storage.googleapis.com/pub/gsutil.tar.gz  && \
  tar xfz gsutil.tar.gz -C $HOME && \
  rm gsutil.tar.gz
ENV PATH $PATH:$HOME/gsutil

RUN mkdir /.ssh
VOLUME ["/.config"]

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron

# Add the backup script
RUN mkdir /etc/bin
COPY mongo-backup.sh /etc/bin
RUN chmod 0744 /etc/bin/mongo-backup.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

COPY gs-init.sh /
COPY gs-lifecycle.json /
ENV GS_PROJECT_ID=discordred
ENV APP_NAME=cronmongo

# hack to use ENV vars in the cronjob
RUN env >> /etc/environment

# Run the command on container startup
# CMD cron && mongod
ENTRYPOINT ["/gs-init.sh"]
