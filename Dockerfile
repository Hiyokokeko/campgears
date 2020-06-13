FROM ruby:2.5.8

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \  
                       nodejs \  
                       imagemagick 

RUN mkdir /campgears
WORKDIR /campgears
COPY Gemfile /campgears/Gemfile
COPY Gemfile.lock /campgears/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY  . /campgears
RUN mkdir -p tmp/sockets
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]