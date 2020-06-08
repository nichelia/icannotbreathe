FROM nichelia/blacklivesmatternow.info:base

ENTRYPOINT ["/bin/bash", "-c", "echo $'\n\t N I C H E L I A  D E V \n' && sleep 5 && npm install && ng update && exec $@"]
CMD ["/bin/bash", "-c", "ng serve --live-reload --watch --progress --verbose --host 0.0.0.0"]