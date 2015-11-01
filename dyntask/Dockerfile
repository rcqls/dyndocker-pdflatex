FROM rcqls/dyndocker-pdflatex:latest

MAINTAINER "Cqls Team"


## Ruby Stuff only for dyndocker-pdflatex-dyntask install

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN apt-get update \
    && apt-get install -y curl procps \
    && apt-get install -y git \
    && apt-get install -y ruby 

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

RUN gem install rake filewatcher

RUN mkdir -p /tmp/dyntask

WORKDIR /tmp/dyntask

RUN git clone https://github.com/rcqls/dyntask-ruby.git 

WORKDIR dyntask-ruby

RUN rake docker

WORKDIR /tmp/dyntask

RUN git clone https://github.com/rcqls/dyndoc-ruby-exec.git 

WORKDIR dyndoc-ruby-exec

RUN rake docker

RUN rm -fr /tmp/dyntask



RUN dyntask-init default /dyndoc-proj:pdflatex



# cleanup package manager

RUN apt-get autoclean && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## the dyndoc projects folder

RUN mkdir -p /dyndoc-proj

VOLUME /dyndoc-proj

WORKDIR /dyndoc-proj


## the pdflatex command

CMD ["/usr/local/bin/dyntask-server","default"]


## END


