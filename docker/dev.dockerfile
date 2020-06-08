FROM nichelia/icannotbreathe:base

ENTRYPOINT ["/bin/bash", "-c", "echo $'\n\t D E V \n' && sleep 5 && npm install && ng update && exec $@"]
CMD ["/bin/bash", "-c", "ng serve --live-reload --watch --progress --verbose --host 0.0.0.0"]