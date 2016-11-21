FROM mongo:3.0
MAINTAINER Brandon Risberg

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron

RUN mkdir /etc/bin
ADD mongo-backup.sh /etc/bin
RUN chmod 0744 /etc/bin/mongo-backup.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron


# Run the command on container startup
CMD cron && mongod
