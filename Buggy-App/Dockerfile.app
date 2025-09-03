FROM 156916773321.dkr.ecr.ap-south-1.amazonaws.com/jayamaran/sample-for-ecs:base
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3
COPY . .
# importing scripts
COPY scripts/entrypoint.sh /app/scripts/entrypoint.sh
RUN chmod +x /app/scripts/entrypoint.sh
RUN bundle exec rake assets:precompile

 
EXPOSE 3000
# executing script 
CMD ["/app/scripts/entrypoint.sh"]
