---
layout: post
title: "March 2016 Sensor Standards Committee Meeting Notes"
modified:
categories: blog
excerpt:
tags: []
image:
  feature:
date: 2016-03-11T20:43:38-05:00
---

# March 2016 Sensor Data Standards Committee Meeting

## **Participants**

David LeBauer, Solmaz Hajmohammadi, Charlie Zender, Ben Niehaus, Max Burnette, Markus Radermacher

## **Agenda**

Objective: define v0 data products, priorities, what we have, what is needed.

Introductions, updates, roadblocks, milestones

1. Ben &amp; Markus
2. Charlie
3. Solmaz

Sample data

1. Data we do and don&#39;t have
2. Review existing meta-data files. [https://goo.gl/QH6PQv](https://goo.gl/QH6PQv)
  a. these taken from sample datasets [https://uofi.box.com/s/c9ngkwi3xvtfr0ei5zfzgf4jya0dmrlc](https://uofi.box.com/s/c9ngkwi3xvtfr0ei5zfzgf4jya0dmrlc)
3. What data products will Lemnatec generate?
4. Calibration: what is known, what will Lemnatec do? What is left to us? SOPs? What is the accuracy and sensitivity of each sensor?

**References:**

1. System Specification (List of sensors p 9-11) [https://goo.gl/Unt0cv](https://goo.gl/Unt0cv)
2. (Some) Sensor data sheets [https://goo.gl/1zcQ0t](https://goo.gl/1zcQ0t)
3. Github issue describing pipeline for hyperspectral data: [https://github.com/terraref/computing-pipeline/issues/38](https://github.com/terraref/computing-pipeline/issues/38)

## **Discussion**

What additional information is required to calibrate sensors and interpret data?

- Hyperspectral / multispectral cameras
  - will use white target time series
  - Bandwidth, spectral resolution, FWHM, spectral response?
  - time of start and end of image capture
- Downwelling solar radiation?
- External color, geometric calibration
  - &quot;3x3 K matrix&quot; (I think this is what R. Pless mentioned for geometric correction / transformation from sensor to reality)
- What does time stamp mean, for sensors that are open for a long time, including
  - imaging spectrometers
  - laser scanner
  - PSII timing of flash / response
- Geospatial information

### **Sensors Missing From Sample Data**

- PAR sensor
- Skye dedicated NDVI
- Color Sensor STS-VIS
- Laser Scanners
- 8 MP RGB Cameras
- Environmental Sensors: Rain, Temp, Humidity, Light, Wind
- Others?

Updates:

Fiber optic cable in transit, should be installed by end of next week

VIS
![VIS](https://github.com/terraref/terraref.github.io/blob/master/images/VIS.png)
