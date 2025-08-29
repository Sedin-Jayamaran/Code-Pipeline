FROM 156916773321.dkr.ecr.ap-south-1.amazonaws.com/jayamaran/sample-for-ecs:base
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3
COPY . .

RUN bundle exec rake assets:precompile

 
EXPOSE 3000
 
CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]
