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

## Further info

**Ninetails** has been developed in the <a href="https://www.iimcb.gov.pl/en/research/41-laboratory-of-rna-biology-era-chairs-group">Laboratory of RNA Biology</a> (Dziembowski Lab) at the <a href="https://www.iimcb.gov.pl/en/">International Institute of Molecular and Cell Biology</a> in Warsaw.
