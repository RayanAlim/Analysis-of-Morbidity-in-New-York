# Death beyond the Numbers: Dissecting New York City's Morbidity Across Demographics


## Overview

Using Morbidity data for New York City, we analyzed the leading causes of death in New York City, segmented by sex and ethnicity, from 2007 to 2014. Utilizing data derived from NYC death certificates, our research offers insights into public health trends and the importance of understanding how these causes of death vary across races. We find that a Poisson distribution is a better fit for modelling leading causes of death by ethnicity, in both rank and magnitude. We also observe that differences in education and behaviour (i.e., smoking prevalence) among ethnicities likely significantly influence differences in age-adjusted mortality rates by cause of death between ethnicities.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from New York City death records.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models.
-   `other` contains relevant literature and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data.

## How to Use This Project

-   Ensure R and necessary libraries are installed.
-   Go to `scripts` to run data simulation, downloading and cleaning scripts.
-   Follow the steps in `model` to conduct the model fitting.

## Statement on LLM usage

No Large Language Models (LLMs) were utilized in the creation or analysis of this project.
