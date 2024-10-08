[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13310035.svg)](https://doi.org/10.5281/zenodo.13310035)

# ninetails_processing
Scripts and code snippets used during the development of **Ninetails** package.

## Containerized usage

Code below allows to pull docker image containing all necessary dependencies & resources to run the ninetails package. This docker does not contain nanopolish and guppy software.

``` 
docker pull ghcr.io/nemitheasura/ninetails-docker:latest
```

> **Note**
>
> This image does not contain Guppy, Nanopolish, minimap2, samtools and other software which is not directly linked with the Ninetails pipeline.

</div>

This command launches docker with `RStudio`: (username: rstudio, password:123)

```
docker run -it -p 8787:8787 -e PASSWORD=123 --rm r-ninetails
```
The access to `RStudio` is provided through the web browser: http://localhost:8787/ (username: rstudio, password:123).

## Training data processing

The **Training_dataset_preparation.Rmd** contains steps for preparing dataset to training the model for neural network. 


## Model training

The **finetunings_script.R** controlled hyperparameters. The model was trained with **Model_finetunings.Rmd**

> **Note**
> 
> **For detailed documentation including explanation of additional dataprocessing and datavis features see <a href="https://github.com/LRB-IIMCB/ninetails/wiki">Ninetails' Wiki</a>**
>
</div>

# Nanopolish Moderna mRNA-1273

Nanopolish version containing subprogram [nanopolish polya-moderna](https://github.com/LRB-IIMCB/nanopolish_mRNA-1273) for identification of mΨCmΨAG pentamer at the 3'end of mRNA-1273 vaccine poly(A) tail. This version of Nanopolish was used in our preprint. 

# Citation

Please cite this repo as:
Gumińska, N., Kulińska-Matylla, K., Krawczyk, P. S., Maj, M., Orzeł, W., Mackiewicz, Z., Brouze, A., Mroczek, S., & Dziembowski, A. (2024). LRB-IIMCB/ninetails_processing: v1.0.0 (v1.0.0). Zenodo. https://doi.org/10.5281/zenodo.13310035

## Further info

**Ninetails** has been developed in the <a href="https://www.iimcb.gov.pl/en/research/41-laboratory-of-rna-biology-era-chairs-group">Laboratory of RNA Biology</a> (Dziembowski Lab) at the <a href="https://www.iimcb.gov.pl/en/">International Institute of Molecular and Cell Biology</a> in Warsaw.
