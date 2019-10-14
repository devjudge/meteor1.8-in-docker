FROM geoffreybooth/meteor-base:1.8.1

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -yq install curl wget
RUN curl -sL https://deb.nodesource.com/setup_10.x  | bash -
RUN apt-get -yq install nodejs

COPY client /tmp/client/
COPY tests /tmp/tests/
COPY server /tmp/server/
COPY package.json /tmp/
COPY package-lock.json /tmp/
COPY .meteor /tmp/.meteor/

WORKDIR /tmp/

EXPOSE 8080

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/node/meteor/build.sh
RUN chmod 775 ./build.sh
RUN sh build.sh

# Add extra docker commands here (if any)...

# Run the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/node/meteor/run.sh
RUN chmod 775 ./run.sh
CMD sh run.sh

