# Use the rocker/rstudio image with R version 4.1.2
FROM rocker/rstudio:4.1.2

LABEL maintainer="nguminska@iimcb.gov.pl"
LABEL description="Ninetails image"

# Install deps
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    bash-completion \
    libxml2-dev \
    zlib1g-dev \
    libxtst6 \
    libxt6 \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libfontconfig1-dev \
    libcairo2-dev \
    libudunits2-dev \
    libgdal-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*


# Copy the package list file into the container
COPY r-requirements.txt /tmp/r-requirements.txt

# Install R packages from the list
RUN echo "Before installing R packages" && \
    while IFS= read -r line; do \
        case "${line}" in \
            *"==CRAN=="*) R -e "install.packages('${line%%==*}', repos='http://cran.rstudio.com/', dependencies=TRUE, version='${line##*==}')";; \
            *"==GITHUB=="*) echo "Installing GitHub package: ${line%%==*}" && R -e "devtools::install_github('${line%%==*}')";; \
            *"==BIOMGR=="*) R -e "BiocManager::install('${line%%==*}')";; \
        esac \
    done < /tmp/r-requirements.txt && \
echo "After installing R packages"


# Download and install Miniconda3 for Linux-x86_64
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add Miniconda3 to the PATH
ENV PATH="/opt/conda/bin:${PATH}"

# Create a virtual environment named r-ninetails in conda based on the file r-ninetails.yml
COPY r-ninetails.yml /tmp/r-ninetails.yml
RUN conda env create -f /tmp/r-ninetails.yml && \
    rm /tmp/r-ninetails.yml


# Expose RStudio port
EXPOSE 8787


# Create a custom entry script
COPY entry.sh /usr/local/bin/entry.sh
RUN chmod +x /usr/local/bin/entry.sh

# Set up entry point to run RStudio with conda environment activated
ENTRYPOINT ["/usr/local/bin/entry.sh"]