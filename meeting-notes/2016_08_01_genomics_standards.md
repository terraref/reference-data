---
layout: post
title: "August 2016 Genomic Standards Committee Meeting Notes"
modified:
categories: blog
excerpt:
tags: []
image:
  feature:
date: 2016-08-01T20:43:38-05:00
---

#
# TERRA Ref Genomics Standards Committee Meeting

## **Participants**

David LeBauer, Christine Laney, Michael Gore, Carolyn Lawrence-Dill, Eric Lyons, Noah Fahlgren

REGRETS:
Todd Mockler, Max Burnette, David Lee, Geoff Morris, Craig Willis

## **Agenda**

Introductions

Objective: review current status of pipeline and plans for first data release in November.

Overview (Noah)

Sequencing

- what has been done
  - 192 resequenced genomes (~20-30x coverage each) from Steve K. bioenergy assoc. panel (BAP)
  - 192 additional samples sent to HudsonAlpha one week ago (20-30x)
  - External funding
    - Illumina for additional ~1000 sequences
    - DOE CSP for de novo
  - Data quality control and analysis to date done on the Danforth Center cluster
    - Trimmomatic =&gt; bwa =&gt; GATK =&gt; CNVator
    - By November: user will upload raw sequencing data and metadata to TERRAref pipeline using CoGe (below)
- what is in pipeline
  - Raw data and experimental metadata added to Clowder
  - Clowder extractor
    - Upload data to the CyVerse data store (TERRA-REF)
    - Launch CoGe workflow using the API
  - Synchronize results back to Clowder/BETYdb

- Clowder: a database that can hold data of any format. Data being imported to clowder will automatically trip extractor that will move data to the correct location for discovery and analysis
- Data will be uploaded to NCBI, SRA
  - Can we link from the SRA to CyVerse and Clowder easily and robustly?

CoGe pipeline

- A sample analysis: [https://genomevolution.org/coge/NotebookView.pl?nid=1344](https://genomevolution.org/coge/NotebookView.pl?nid=1344)
- Draft implementation: [https://github.com/terraref/computing-pipeline/blob/f94a87f851b37ff74ded5b7b6b3b0c1e13107720/scripts/coge/coge\_upload.json](https://github.com/terraref/computing-pipeline/blob/f94a87f851b37ff74ded5b7b6b3b0c1e13107720/scripts/coge/coge_upload.json)

Downstream Analyses

- GOBII
- Other downstream tools?
  - SNP callling via CoGe
  - What is already within CoGe
  - Putting proprietary GATK on CyVerse (Mike G will send more info)
  
Data Sharing

- when, where, and with what will we share as of November
- Currently using CyVerse data store ( [https://de.iplantcollaborative.org/de/](https://de.iplantcollaborative.org/de/))
  - [terraref/reference-data/19](https://github.com/terraref/reference-data/issues/19)
- Phytozome  (a DOE database)- is this an appropriate for our data? Perhaps not for raw reads (Mike G)
  - Maybe we can submit variation information from the CoGe pipeline and update it as the reference genome is updated
  - Is Phytozome interested in hosting a pangenome resources?
- NCBI SRA: raw data + experimental metadata
  - NEON has worked with SRA on data/metadata sharing, keep in touch with them
- Others?

Other questions / ideas

- How to get from genbank to related

NEON: providing metagenomic data, processed and made available to the public w/ mgrast; marker gene sequences will be hosted in SRA / not available w/in NEON portal but available from external repository. Genomic standard meeting next week, working on environmental soil meta-data package for Mixs [http://gensc.org/mixs/submit-mixs-metadata/](http://gensc.org/mixs/submit-mixs-metadata/)

NEON has started using EML to begin documenting sensor and observational data (currently online at [http://data.neonscience.org](http://data.neonscience.org) but not pretty). May begin doing this w/ soil samples.

Action items:

### **References**

- Genomics pipeline documentaiton [https://github.com/terraref/documentation/blob/master/genomics\_pipeline.md](https://github.com/terraref/documentation/blob/master/genomics_pipeline.md)
- Genomics data formats: [terraref/reference-data/19](https://github.com/terraref/reference-data/issues/19)
- Pipeline implementation: [terraref/computing-pipeline/issues/37](https://github.com/terraref/computing-pipeline/issues/37)
- Using CoGe [terraref/computing-pipeline/issues/41](https://github.com/terraref/computing-pipeline/issues/41)
