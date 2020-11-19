FROM silex/emacs:26.3-alpine

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"  

VOLUME /site
WORKDIR /site

COPY org/bin/ /bin

RUN apk update && apk add make tree git python3 gnuplot openjdk8 ncftp ttf-freefont graphviz

COPY org/publish.el /root/.emacs
RUN emacs --batch --load /root/.emacs

CMD ['make emacs']
