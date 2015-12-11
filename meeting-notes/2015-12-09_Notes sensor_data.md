# TERRA sensor data standards teleconference				December 9, 2015

David LeBauer (UIUC)

Christine Laney, Josh Elliot (Neon)

Melba Crawford (Purdue)

Shawn Serbin (BNL)

Yewin Shi (Texas A&M)

Charlie Zender (UCI)

Josh Elliot (NEON)

Ed Delp (Purdue)

Larry Biel



[issue #2](https://github.com/terraref/reference-data/issues/2)

* Meta-data format for raw data Lemnatec – Is there anything that we’re missing?**
 * Dependent on instrument?  Yes, there is a code for each sensor.
 * What is “raw”?  Has a calibration been applied?  Is the hyperspectral data in radiants?  There are two sets of files - one has been corrected.
 * Integers can save space, rather than floating points, this will allow you to compute on the fly
* Where is meta-data for conversion/ integer scale? Scale, add_offset  It may be safer to save raw data in case there is a conversion error.  This may result in the need for multiple data releases.
 * Keep raw reflectance data and convert to radiants data 
 * David to find out how this is handled for the system at Lincoln
* We will have three dimensional surface of plants with laser scanner for normalizaiton. This seems like a very difficult research-level problem
 * BRDF
 * TERRA Ref should create protocols for doing corrections so that a common panel can be shared? (Christine Laney)
 * Calibration for light, distortion needed – is Lemnatec doing that?  Can the calibration data be distributed? David to develop a list
 * Feedback for sampling and frequency - none
 * David to develop mailing lists in January.
