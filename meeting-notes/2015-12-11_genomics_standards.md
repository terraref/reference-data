---
layout: post
title: "December 2015 Genomic Standards Committee Meeting Notes"
modified:
categories: blog
excerpt:
tags: []
image:
  feature:
date: 2015-12-11T20:43:38-05:00
---

# Genomic Data Meeting
December 11, 2015

Rachel Shekar  
David LeBauer  
Christine Laney (Neon)  
Eric Lyons (AZ)  
Mike Gore (Cornell) 
David Lee (DOE)  
Elodie (Cornell)  
  
-   Eric has a similar pipeline is already developed but can share with Mike

    -   May reads using bowtie, tophat…

    -   Can call SNPS multiple ways

    -   Leads to Jbrows

-   User cases and speed need to be known before we will know if this works

    -   Mike has 500 lines with 3-4x coverage

    -   David LeBauer thinks in total, TERRA will have 200 lines in year 1 and 2 with 40x coverage and some with 100x coverage. Ask David Lee if this is correct.

    -   Elodie doesn’t think 200x is correct; 40x is a lot. What is it compared to human genome? What is the return on that volume? The processing, computing, and processing time would be too high. If someone wants to use 100x, we need to prepare for that.

-   Eric can run benchmarking with Elodie’s test data sets before sending them through.

-   Eric’s pipeline can likely be put in repository – Open Source

    -   Pipeline = major tools

    -   Do you want integration system too?

    -   They can do customization

    -   [http://genomevolution.org](http://genomevolution.org/)

    -   They have bulk upload capabilities and bulk metadata upload and management

    -   They can co-develop with UofI team

    -   Data can be transferred with API

-   David to meet with Eric in Arizona

Installation for CoGe: https://genomevolution.org/wiki/index.php/Install\_coge
