FROM registry.access.redhat.com/ubi9/python-312

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

USER root
RUN dnf -y install httpd

# Setup
ENV APP_HOME /app
WORKDIR $APP_HOME

# Dependencies
COPY ./requirements.txt ./
RUN python3 -m pip install --upgrade pip && pip install -r ./requirements.txt

# Copy code
COPY . .

# Final configs
EXPOSE 8080
ENV PORT 8080
ENV TARGET World
USER nobody

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
