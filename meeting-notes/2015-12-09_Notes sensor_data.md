# TERRA sensor data standards teleconference				December 9, 2015

David Lebauer (UIUC)

Christine Laney, Josh Elliot (Neon)

Melba Crawford (Purdue)

Shawn Serbin (BNL)

Yewin Shi (Texas A&M)

Charlie Zender (UCI)

Josh Elliot (NEON)

Ed Delp (Purdue)

Larry Biel



[issue #2](https://github.com/terraref/reference-data/issues/2)
**•	Meta-data format for raw data Lemnatec – Is there anything that we’re missing?**


o	Dependent on instrument?  Yes, there is a code for each sensor.

o	What is “raw”?  Has a calibration been applied?  Is the hyperspectral data in radiants?  There are two sets of files – one has been corrected.

o	Integers can save space, rather than floating points, this will allow you to compute on the fly

o	Where is meta-data for conversion/ integer scale? Scale, add_offset  It may be safer to save raw data in case there is a conversion error.  This may result in the need for multiple data releases.

o	Keep raw reflectance data and convert to radiants data 

o	David to find out how this is handled for the system at Lincoln

o	We will have three dimensional surface of plants with laser scanner for normalizaiton

o	BRDF

o	Is a group creating protocols for doing corrections so that a common panel can be shared? Christine Laney

o	Calibration for light, distortion needed – is Lemnatec doing that?  Can the calibration data be distributed? David to develop a list

o	Feedback for sampling and frequency - none


o	David to develop mailing lists in January.
