FROM mambaorg/micromamba:1.5.8

COPY environment.yml /tmp/environment.yml

RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean -a -y

ENV PATH=/opt/conda/bin:$PATH
ENV R_LIBS_SITE=/opt/conda/lib/R/library

USER root

RUN R -q -e 'remotes::install_github("igordot/copynumber")' && \
    R -q -e 'remotes::install_github("VanLoo-lab/ascat/ASCAT")' && \
    R -q -e 'remotes::install_github("Wedge-lab/battenberg")'

RUN mkdir -p /refs/battenberg_hg38 /data /work
COPY test_install.R /usr/local/bin/test_install.R
WORKDIR /work

CMD ["/bin/bash"]
