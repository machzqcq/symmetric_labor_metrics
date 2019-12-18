FROM python:3.6.5

ARG BUILD_DATE
ARG VCS_REF

# Traceability to source code
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/machzqcq/symmetric_labor_metrics.git" \
    org.label-schema.vendor="Pradeep Macharla." 

ADD . /code/
WORKDIR /code
RUN pip3 install -r script/requirements.txt