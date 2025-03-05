FROM ruby:3.2

RUN apt-get update && apt-get install -y postgresql-client

WORKDIR /app
COPY . .

RUN gem install bundler && bundle install

CMD ["bash"]
