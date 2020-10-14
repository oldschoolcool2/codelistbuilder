FROM 354388601783.dkr.ecr.eu-west-1.amazonaws.com/shiny:3.6.1-20191015

USER root
RUN R --quiet -e "install.packages(c('openxlsx', 'shinydashboard', 'feather', 'data.table', 'DT', 'shinyjs', 'shinyalert'), quiet = TRUE)"
USER shiny

COPY --chown=shiny:shiny . /srv/shiny-server
