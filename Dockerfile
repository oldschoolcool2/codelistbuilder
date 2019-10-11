FROM 833333815239.dkr.ecr.us-east-1.amazonaws.com/container-shiny:v1.1.0

USER root
RUN R --quiet -e "install.packages(c('openxlsx', 'shinydashboard', 'feather'), quiet = TRUE)"
USER shiny

COPY --chown=shiny:shiny . /srv/shiny-server

ARG container_credentials
ENV AWS_CONTAINER_CREDENTIALS_RELATIVE_URI $container_credentials

RUN aws s3 sync --quiet s3://$BUCKET_NAME/data /srv/shiny-server/data

