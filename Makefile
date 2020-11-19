SITE=:"ftp.fastmail.com"
REMOTE_FOLDER=:"/neil.grogan.org/files/public"
DOCKER_IMAGE:=dueyfinster/site
.PHONY: all clean

all: clean build

clean:
	bundle exec jekyll clean

install:
	sudo gem install bundler && bundle install

build:
	bundle exec jekyll build --incremental

serve:
	bundle exec jekyll serve -H 0.0.0.0

publish: build
	ncftpput -u $USER -p $PASS -R $SITE $REMOTE_FOLDER ./; fi
	
emacs:
	emacs --batch --no-init-file --load org/publish.el

docker-build:
	docker build -t ${DOCKER_IMAGE} .
	
docker:
	docker run -it -v ${PWD}:/site ${DOCKER_IMAGE} make emacs
	
	