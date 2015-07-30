FROM debian:testing

MAINTAINER "Cqls Team"

## Latex texlive full without doc

RUN mkdir /texlive2014nodoc

WORKDIR /texlive2014nodoc

COPY full2014nodoc.profile /texlive2014nodoc/

RUN apt-get update \
    && apt-get install -y wget tar perl fontconfig \
    && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
     && tar -xvf *.tar.gz 
RUN cd install-tl-* \
    && ./install-tl --profile /texlive2014nodoc/full2014nodoc.profile

RUN rm -fr /texlive2014nodoc

ENV PATH $PATH:/usr/local/texlive/2014/bin/x86_64-linux

## the dyndoc projects folder

RUN mkdir -p /dyndoc-proj

VOLUME /dyndoc-proj

WORKDIR /dyndoc-proj


## the pdflatex command

CMD ["/usr/local/texlive/2014/bin/x86_64-linux/pdflatex"]


## END


