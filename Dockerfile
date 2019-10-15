FROM 354388601783.dkr.ecr.us-east-2.amazonaws.com/shiny:3.6.1-20191015

USER root
RUN R --quiet -e "install.packages(c('openxlsx', 'shinydashboard', 'feather'), quiet = TRUE)"
USER shiny

COPY --chown=shiny:shiny . /srv/shiny-server
