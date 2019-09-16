# Dataset for spatio-temporal analysis of the effects of management strategies on the abundance of marine organisms
## data/data.csv  
### General description  
The data comprise four responses that represent counts (abundance) of four different marine reef fish (columns `damsel`, `wrasse`, `parrotfish` and `grouper`). These counts are collected along fixed length transects permanently marked to permit revisiting over time.  

There are four regions (column `Region`) representing four separate jurisdictions or management areas. Within each region there are 10 sites (column `Site`), half of which are managed according to one strategy (column `Management`: `a`) and the other half are managed according to an alternative strategy (`Management`: `b`). It is important to note that:  

- The sites themselves are blocked (column `Block`) such that within each block there are two sites of each management strategy;  

- Hence within each region there are five blocks. The blocks represent a design decision to group together sets of sites from each management strategy in an attempt to reduce the unexplained variability due to the expected underlying spatial heterogeneity;  

- Within each site there are 3 transects (column `Transect`), i.e. the sampling unit from which count data are collected. The responses therefore represent the number of individuals encountered along each transect;  

- All transects are the same length and effectively sample the same approximate area;  

- Each transect is sampled annually at approximately the same time each year (column `Year`);  

- Importantly, the management strategies actually only became differentiated after the forth year of
sampling. Hence the first four years of data are considered baseline knowledge.  
