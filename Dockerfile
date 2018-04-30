FROM 833333815239.dkr.ecr.us-east-1.amazonaws.com/container-shiny:v1.1.0


# RUN ln -s /etc/jdbc/AthenaJDBC41-1.1.0.jar /srv/shiny-server/lib/AthenaJDBC41-1.1.0.jar

USER root
RUN R --quiet -e "install.packages(c('openxlsx'), quiet = TRUE)"
USER shiny

# COPY --chown=shiny:shiny . /srv/shiny-server
COPY . /srv/shiny-server

ARG container_credentials
ENV AWS_CONTAINER_CREDENTIALS_RELATIVE_URI $container_credentials

RUN aws sts get-caller-identity

RUN aws s3 sync s3://hcie-codelist-builder/data /srv/shiny-server/data

# RUN aws s3 sync s3://sunshine-act/shiny_server/ /srv/shiny-server/

