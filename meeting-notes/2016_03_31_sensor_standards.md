---
layout: post
title: "March 31,  Sensor Standards Committee Meeting Notes"
modified:
categories: blog
excerpt:
tags: []
image:
  feature:
date: 2016-03-31T20:43:38-05:00
---

# March 31, 2016 Sensor Data Standards Committee Meeting

## Participants

David LeBauer, Chris Boomsma, Larry Biehl, Ed Delp, Melba Crawford, Solmaz Hajmohammadi

Charlie Zender, Matt Colgan, Alex Thomasson

## Agenda

### Updates on Lemnatec Field Scanner in Arizona

Sample data from wheat is available

Sorghum planting scheduled for mid-April

### Review of initial data sets and products

Raw data sets available

- How to access raw data: Globus, Clowder (by request, not yet public - Maloney, John Daniel &lt;malone12@illinois.edu&gt;)
- Plans for v0 sensor data products

- Data stream for environmental sensors (including meteorology and downwelling spectra)
  - Sample data set   [2016-02-15\_21-20-08\_enviromentlogger.json.txt](https://github.com/terraref/reference-data/files/178402/2016-02-15_21-20-08_enviromentlogger.json.txt) and discussion on [Github issue 26](https://github.com/terraref/reference-data/issues/26):
  - [Draft format specification](https://github.com/terraref/documentation/blob/master/environmental_data.md)
- Hyperspectral and imagery data - Charlie Zender
  - Ugly workflow [script](https://github.com/terraref/computing-pipeline/tree/master/scripts/hyperspectral/terraref.sh) (convert raw-&gt;netCDF, compress, add metadata)
  - [Help screen](https://gist.github.com/czender/39b5249dd92c3b8f471beda7bbc121c5)
  - [Run output](https://gist.github.com/czender/bdd93e4d67aeca8b5c11bd916c655db9#file-terraref-out)
  - Review sample [data](http://dust.ess.uci.edu/tmp/foo.nc) (warning: 134 Mb) and/or [metadata](http://dust.ess.uci.edu/tmp/foo.cdl)
    - People will be most interested in looking at band-specific data so the default script is simplified for this.
    - Lossless compression by Deflate is 20-25% with no loss of data with less than 5 s to decompress.  Higher compression will cause longer decompression time
    - Lossy compression is an option (bit rounding), then compressing with lossless compression to get an extra 10% saving per decimal digit
- Gantry sensors
  - How to correct if velocity is not constant?  Also problems with GPS if moving very slowly.
  - All lemnatec GFE cameras are operating independently and data will be combined later (image stitching)
  - Speed of gantry and start time positions known.  Timestamp with text file accurate to millisec.  Accurate to second when the mirror angle is changing, and the gantry is not moving.
  - Any info on reflectance calibration?  What should we do for calibration?

### Discussion

- What are the priority use cases to support?
- (How and where) might you use software components?
- Are you interested in either contributing data or adopting common standards?
- Calibration
  - Light
  - Space
  - Time

### GitHub issues

- Complete list of [Open Github Issues related to Sensor Data](https://github.com/search?q=org%3Aterraref++label%3A%22sensor+data%22&amp;ref=searchresults&amp;state=open&amp;type=Issues&amp;utf8=%E2%9C%93)
- Issue 64: [First step of processing and annotating sensor output](https://github.com/terraref/computing-pipeline/issues/64)
- Issue 14: [Formats for image and other hyperspectral data](https://github.com/terraref/reference-data/issues/14)
