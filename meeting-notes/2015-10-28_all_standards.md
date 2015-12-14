> <span id="Reference_Standards_Committee_Virtual_Me" class="anchor"></span>Reference Standards Committee Virtual Meeting Notes
>
> October 28, 2015 2pm EST
>
> In attendance: David Lee (ARPA-E), David LeBauer (UIUC), Alex Thomasson (TAMU), Barnabas Pocnos (CMU), Christer Jansson (PNNL), Dan Northrup (ARPA-E), Ed Delp (Purdue), Elodie Gazave (Cornell), Justin Manzo (ARPA-E), Larry Biehl (Purdue), Matt Colgan (BRT), Melba Crawford (Purdue), Mike Gore (Cornell), Elodie Gazave (Cornell)

1.  Review location of the following information:

    1.  [*TERRAref documentation website*](https://dlebauer.gitbooks.io/terraref-documentation/content/data_standards_committee.html)

        -   Please free to make or suggest edits

    2.  [*Github website*](https://github.com/terraref/reference-data)

    3.  [*Danforth plantcv site*](http://plantcv.danforthcenter.org/)

    4.  [*Sample data available in Box*](https://uofi.app.box.com/terraref-sample-data)

        -   Do you have any other ideas for storage

Q. Christer – molecular phenotyping, including transcriptomics/proteomics/metabolomics – should this be added to the ontology, reference data. Spatiotemporal, qualitative and quantitative. Very large dataset.

A. This is not in the scope of the reference data that we are providing, but uses are welcome to develop a proposal. Talk to Mike Gore, Christer and David Lee about developing a proposal for molecular phenotyping. This data type is quite specialized. This could be built in later, but we don’t want to overlap with kbase and iplant. TERRAref is currently handling genetic and phenotypic data and trying to link these – there is a possibility for molecular data to be linked using these resources.

Q. Justin – Can’t sync content from box

A. Look into changing permission

Cornell can provide a template for genomics data.

1.  Member information

    1.  Identify each participant's expertise and interests with respect to the committee (see list of expertise and interests, below)

        -   We can provide a file for edits

        -   We need to identify one person from each funded project to be the point person and attend annual meetings. Anyone can join call, be on the email list, and provide feedback.

        -   We will be supporting robotics, but TERRAref is not necessarily supporting it

    2.  Any additional external member suggestions?

        -   We have USDA, NASA, Neon

        -   External person to represent genomics data

            -   JGI John Vogel (via Christer Jansson), though is part of a TERRA team

            -   Others? (via Dan Northrup and David Lee)

        -   External person to represent robotics

2.  Review specifications for Lemnatec Field system

    1.  identify additional data / meta-data that will be required [*https://github.com/terraref/reference-data/issues/2*](https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_terraref_reference-2Ddata_issues_2&amp;d=BQMFaQ&amp;c=8hUWFZcy2Z-Za5rBPlktOQ&amp;r=Gy0uSqCgH64pIwd523tNNELrWIy2rVBfYvwBsLceSP0&amp;m=MaAgfvLTXIWTX_NKKuX8rUCL78m83nkc_LwVrotas0U&amp;s=wlg0a7El02RV5vRE8qyQsXWqMjQDE0CQQKix-KYpjpc&amp;e)

        -   Showed location of data in box and how the sensor data is organized. Each sensor has raw and meta data files.

        -   What is important to keep in each of the meta data files besides what is already embedded in the database? This includes information about the sensors.

        -   Q. Melba unsure if the data in the folders is the actual output of the sensors. Are these Headwall output with correcting sensors or straight sensors? We need to know if it’s already been corrected to that output format.

            -   David Lebauer will talk with Melba about this and determine how to best follow up.

        -   TERRAref will not be using Lemnatec’s proprietary software because it is not created for all of the sensors that we are using and because we want to be in control of the algorithms

        -   TERRAref will process sensor data into datacubes

3.  Discuss proposed semantics and formats

    1.  Meteorological variables [*https://github.com/terraref/reference-data/issues/3*](https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_terraref_reference-2Ddata_issues_3&amp;d=BQMFaQ&amp;c=8hUWFZcy2Z-Za5rBPlktOQ&amp;r=Gy0uSqCgH64pIwd523tNNELrWIy2rVBfYvwBsLceSP0&amp;m=MaAgfvLTXIWTX_NKKuX8rUCL78m83nkc_LwVrotas0U&amp;s=usuf7lhfnf1R4FB3AYpyWaRNSNswmcGi5yXewI1rCgk&amp;e)

        -   Ed Delp will look at this in more detail

    2.  Imaging and hyperspectral data [*https://github.com/terraref/reference-data/issues/14*](https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_terraref_reference-2Ddata_issues_14&amp;d=BQMFaQ&amp;c=8hUWFZcy2Z-Za5rBPlktOQ&amp;r=Gy0uSqCgH64pIwd523tNNELrWIy2rVBfYvwBsLceSP0&amp;m=MaAgfvLTXIWTX_NKKuX8rUCL78m83nkc_LwVrotas0U&amp;s=emB6y89ydGTN34Tb-RXIMQYbAwMrA7StpXI_dwXQcx0&amp;e)

        -   Feel free to provide feedback on github

        -   Matt Colgan to talk to David Lebauer offline about his

    3.  Plant traits [*https://github.com/terraref/reference-data/issues/18*](https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_terraref_reference-2Ddata_issues_18&amp;d=BQMFaQ&amp;c=8hUWFZcy2Z-Za5rBPlktOQ&amp;r=Gy0uSqCgH64pIwd523tNNELrWIy2rVBfYvwBsLceSP0&amp;m=MaAgfvLTXIWTX_NKKuX8rUCL78m83nkc_LwVrotas0U&amp;s=orlCluEw2NObbz94phzE6tyW7omHjrM30RsSFs2h098&amp;e)

        -   ICASA provides many traits, but not all that we will need. David Lebuaer suggest to create a table of cross-referring from different databases.

        -   What resource should molecular phenotype trait standard names be derived from?

4.  Other business?

-   There will be an in person meeting in Pittsburgh at the Kickoff for data standards at the end of the first day (5 pm).

    -   David will give an overview of the data management plan as part of the Cat 5 session earlier in the day, so there may be general interest in this topic.

    -   Should the meeting be open to everyone or just the leads? Space for 25-30

    -   David Lee and David LeBauer to work with Rachel Shekar to develop an agenda

-   TERRAref needs sample analyses tom better create data products and develop pipelines.

-   Would like to better understand how the data will be used. Please provide feedback on specific applications that the different data types will be used, and in what formats will be most useful. Also discuss the scope of data that will be used. For example, will people just need to look in depth at a few plots, or want to regularly analyze the whole field.

> Committee expertise and interests

|                    | **genomics/ genetics**   | **sensor data**   | **image analysis**   | **robotics**   | **physiology**   | **modelling**   |
|--------------------|--------------------------|-------------------|----------------------|----------------|------------------|-----------------|
| Paul Bartlett      |                          | x                 |                      | x              |                  |                 |
| Matt Colgan        |                          | x                 |                      |                | x                |                 |
| Melba Crawford     |                          | x                 | x                    |                |                  |                 |
| Michael Gore       | x                        |                   |                      |                | x                | x               |
| Christer Janssen   | x                        |                   |                      |                | x                |                 |
| Christine Laney    |                          | x                 |                      |                |                  |                 |
| Shelly Petroy      |                          | x                 |                      |                |                  |                 |
| Barnabas Poczos    |                          | x                 | x                    |                |                  |                 |
| Cheryl Porter      |                          |                   |                      |                |                  | x               |
| Shawn Serbin       |                          | x                 | x                    |                | x                | x               |
| Alex Thomasson     |                          | x                 | x                    |                | x                |                 |
| Jeff White         | x                        |                   |                      |                | x                |                 |
| David Lee          | X                        |                   |                      |                | x                |                 |
| Ed Delp            |                          | X                 | X                    |                |                  |                 |
