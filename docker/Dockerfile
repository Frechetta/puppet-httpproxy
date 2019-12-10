FROM ruby

RUN wget https://apt.puppet.com/puppet-tools-release-stretch.deb && \
    dpkg -i puppet-tools-release-stretch.deb && \
    apt update && \
    apt install pdk

RUN gem install bundler

WORKDIR /app

COPY Gemfile ./

RUN bundle install
