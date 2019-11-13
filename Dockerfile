# ./Dockerfile

# Extend from the official Elixir image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client && \
  apt-get -y install curl gnupg && \
  curl -sL https://deb.nodesource.com/setup_11.x  | bash - && \
  apt-get -y install nodejs 


# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

RUN mix deps.get 

CMD ["/app/entrypoint.sh"]