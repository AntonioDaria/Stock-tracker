#pull ruby image
FROM ruby:2.5.1

# updating package index and installing the database package
RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    postgresql-client \
    nodejs\
    && rm -rf /var/lib/apt/lists


# creating the app folder
RUN mkdir /app

#coping the gemfile in the app folder
COPY Gemfile* /app/

#letting docker know that every command from this point is running in the app folder
WORKDIR /app


RUN bundle install

#copy the whole content of the app(project) in the app folder
COPY . /app/

# we are letting docker know that we have something running on port 3000
EXPOSE 3000

#launch it
CMD ["rails", "server", "-b", "0.0.0.0"]
