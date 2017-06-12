FROM golang:alpine
#ENV CGO_ENABLED=0  --> replaced by modified LDFLAGS and CC/gcc, because disabling CGO seems to have several impacts
WORKDIR $GOPATH/src/github.com/coreos/container-linux-config-transpiler
RUN apk update && apk add --virtual .build-deps bash git gcc musl-dev curl jq && \
	git clone https://github.com/coreos/container-linux-config-transpiler . && \
	sed -i -e 's/^\(GLDFLAGS=".*\)\("[ ]*\)$/\1 $GLDFLAGSX\2/' -e $'s/^GLDFLAGS=/CC=`which gcc`\\nGLDFLAGSX="-w -linkmode external -extldflags \\\\"-static\\\\""\\n&/' build && \
	./build && \
	mv bin/ct /usr/bin/ && mv Dockerfile.build-scratch /tmp && \
	rm -rf $GOPATH
#	apk del .build-deps && rm -rf /var/cache/apk
WORKDIR /tmp

COPY propagate.sh .

ENTRYPOINT ["./propagate.sh"]
