FROM resin/rpi-raspbian:stretch
LABEL maintainer="david.c.mitchell@gmail.com"

RUN sudo apt-get update
RUN sudo apt-get install build-essential libncurses5-dev libncursesw5-dev libssl-dev

ENV APP_ROOT /opt/app
RUN mkdir -p ${APP_ROOT}

WORKDIR ${APP_ROOT}
RUN curl -LO http://www.erlang.org/download/otp_src_20.2.tar.gz
RUN tar -xvzf otp_src_20.2.tar.gz
RUN curl -LO https://github.com/elixir-lang/elixir/archive/v1.5.3.tar.gz
RUN tar -xvzf v1.5.3.tar.gz

WORKDIR ${APP_ROOT}/otp_src_20.2
RUN export ERL_TOP=`pwd`
RUN ./configure
RUN make
RUN make install

WORKDIR ${APP_ROOT}/elixir-1.5.3
RUN make

RUN rm -Rf ${APP_ROOT}/otp_src_20.2
RUN mv ${APP_ROOT}/elixir-1.5.3 /usr/local/lib/elixir-1.5.3
RUN ln -s /usr/local/lib/elixir-1.5.3 /usr/local/lib/elixir
ENV PATH /usr/local/lib/elixir/bin:$PATH

ENTRYPOINT [ "/usr/local/lib/elixir/bin/iex" ]
