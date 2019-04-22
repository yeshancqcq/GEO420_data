# GEO420_data
Processing the data of the glacier project (Shan Ye and Emily Mixon)
This is a part of the class project of Geo420 at University of Wisconsin-Madison, Spring 2019 semester
The project is on the glaciation history of southern Chili (Andes) in Pleistocene and Holocene
Files in the main folder: 
main.R (main function to process the data)
jsonToDf.R (a function converting input json fild to data frame)
chile_ar_ar.bibjson (the json file containing information of potential papers to work with. Proviced by Ian Ross via GeoDeepDive)
anomaly_autoGen.R is used to generate anomalies of temperature. We decided to use anomalies rather than real temperature records to get ride of weighting issues of our spatial-temporal data. The temperature records at 10,000 years bp were chosen to be reference temperatures. Datasets that do not contain a record at 10,000 bp were dropped. Among all datasets from Marcott and Shakun data, 9 were dropped. 

We are also using some datasets selected from Shakun and/or Marcott's publications. Their datasets are plotted at https://yeshancqcq.github.io/paleo/paleo_index.html as interactive maps. Based on their locations, we are going to use these following datasets in our analysis:

South America west coast sites (with thier ids in Shakun and/or Marcott datasets):

GeoB 7139-2 (Shakun 68, Marcott 26)
GeoB 3313-1 (Marcott 33, dropped, no reference at 10,000 bp)
ODP 1233 (Shakun 71)

Antarctica sites:

EDML (Shakun 77, Marcott 61)
Dome F Antarctica (Shakun 79, Marcott 27)
Vostok Antarctica (Shakun 80, Marcott 50)
Dome C Amtarctoca (Shakun 78, Marcott 25)

In addition to Andes, we also use Kamchatka and New Zealand records as comparisons. We have volcanic datasets for Kamchatka, but we do not currently have temperature records in that peninsula. Therefore, we used temperature records from Japanese sites as a reference:

Japanese sites:

PC-6 (Shakun 12)
KT92-17_Site14 (Shakun 22)
The composite site MD01-2421; KR02-06 St.A GC; KR02-06 St.A MC (Marcott 23. dropped, no reference at 10,000 bp)

New Zealand site:
SO136-GC11 (Shakun 74, Marcott 3)
MD97-2121 (Shakun 70, Marcott 48)
MD97-2120 (Marcott 47)
Mount Honey (Marcott 44)

