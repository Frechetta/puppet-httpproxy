FROM ruby

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN wget https://apt.puppet.com/puppet-tools-release-stretch.deb && \
    dpkg -i puppet-tools-release-stretch.deb && \
    apt update && \
    apt install pdk && \
    gem install bundler && \
    bundle install
