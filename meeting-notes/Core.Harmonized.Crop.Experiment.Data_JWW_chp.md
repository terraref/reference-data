Core Harmonized Crop Experiment Data 
=====================================

The purpose of this section is to provide a list of data that are
commonly collected in agronomic field experiments. We refer to this list
as the “Core Crop Data” that we aim to harmonize among different
locations and crops. Note, however, that not all of these data are
collected in every experiment so one would not want to use this as a
check list for determining whether a particular set of data is
appropriate for the NADN. A good example of valuable data that would not
have all of these variables measured is yield trials, which are
routinely conducted annually in many locations to evaluate performance
of crop varieties available to producers. We have found these data to be
highly valuable in that they are conducted in multiple locations each
year and have information on yield effects of weather, daylength, soil,
and variety. This type of data, for example, has been very useful in
studying impacts of climate variability and climate change on yield and
has also been used to estimate genotype-specific parameters for
cultivars/hybrids. On the other hand, researchers may collect more data
than those listed in this section for many studies that are conducted
annually. This list can be extended to include other measurements.
Initially, we will make use of this list of variables for harmonizing
data amongst states and years.

In order to characterize growing conditions and crop growth progression,
researchers typically collect a core set of data which could be the same
across many different types of experiments. However, the information
collected varies somewhat depending on the purpose of a study. For
example, many studies are conducted to compare yields among a range of
genotypes of a particular crop (typically referred to as yield trials).
Some states have yield trial data on line and should be considered as a
target for harmonization, even though those trials typically will not
have many of the variables measured that can be harmonized. Other
studies may be performed to compare growth and yield of a particular
crop variety under different fertilizer, irrigation, or other management
practices. The amount of information collected in these two types of
studies may vary, but typically researchers will record management,
daily weather, anthesis date, and yield information at minimum (e.g.,
yield trials) and may record much more than that for studies designed to
understand ways of improving management of crops. For example, many
researchers record more details about timing of vegetative and
reproductive growth stages and they may collect samples periodically
during the season to measure biomass in leaves, stems, and fruit in
addition to soil water changes over time and end of season yield
components.

Crop models need to be evaluated across a range of weather, soil, and
management conditions to ensure their applicability for informing policy
makers, industries, and management decisions. These types of studies
with weather, management, soil, and crop yield across years and
locations have proven to be valuable sources of information for studying
effects of climate variability on crops, for example, to help understand
possible impacts of climate change across regions on crop productivity.
These data are also highly useful for parameterizing models of crops,
which are then more reliable when used to predict crop yields over time
or across locations where data were not observed. The following list of
variables is based on prior experiences of a number of research groups
in developing, parameterizing, and evaluating both statistical and
process-based crop models. Many studies that are conducted annually
include all or many of these data, and these data are included in the
ICASA Data Dictionary (White et al., 2014) and were used by the AgMIP
project to harmonize data for use in multiple crop models (Porter et
al., 2014). The purpose of the list is to provide a core set of data
that will be harmonized across studies to provide data interoperability
for the NADN. For example, if an existing database has these data, we
can connect the NADN to that database and translate the variables into a
harmonized list using the ICASA Data Dictionary. Over time, this list
can be extended by adding other variables.

This list is a subset of the ICASA Data Dictionary used by AgMIP (White
et al., 2014; Porter et al., 2014) to harmonize data used for operating,
evaluating, and improving crop models. It continues to evolve for crops
based on input from a wide range of researchers. During this project,
similar lists and data dictionaries will be developed for dairy and beef
systems. For now, we only show this list for crops. Additionally, we
have an EXCEL Spreadsheet that has these variables with units defined
and codes that are used by the software that reads these data for
harmonizing the data. This spreadsheet is available on request, although
additional changes are being made as needed (it is a living document).

### <span id="_Toc432333645" class="anchor"><span id="_Toc432340262" class="anchor"><span id="_Toc432409192" class="anchor"><span id="_Toc432428323" class="anchor"><span id="_Toc432428422" class="anchor"></span></span></span></span></span>Characterization of Field Experiments

  ***A.***   ***General Site Description***                                                                                                                                                                                                                                                                            ***Variable name***           ***Short Name***   ***Definition***                                                    ***Units***
  ---------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------- ------------------ ------------------------------------------------------------------- -----------------
  1          Location of experiment (GPS coordinates, on station, on farm)                                                                                                                                                                                                                                             experiment\_name\_local       LOCAL\_NAME        Locally used name for experiment                                    text
                                                                                                                                                                                                                                                                                                                       site\_name                    SITE\_NAME         Name of site for experiment                                         text
                                                                                                                                                                                                                                                                                                                       field\_latitude               FL\_LAT            Field latitude                                                      decimal degrees
                                                                                                                                                                                                                                                                                                                       field\_longitude              FL\_LONG           Field longitude, E positive, W negative                             decimal degrees
  2          Physical attributes of field (area, slope)                                                                                                                                                                                                                                                                field\_area                   FAREA              Field area                                                          m2
                                                                                                                                                                                                                                                                                                                       field\_length\_width\_ratio   FLLWR              Field length to width ratio                                         number
                                                                                                                                                                                                                                                                                                                       field\_slope                  FLSL               Field slope (from horizontal)                                       percent
  3          Drainage characteristics                                                                                                                                                                                                                                                                                  drainage\_type                FL\_DRNTYPE        Drainage, type in field                                             code
  4          Water table depth                                                                                                                                                                                                                                                                                         water\_table\_depth           DTWT               Water table depth                                                   cm
  5          General purposes of experiments (descriptive text e.g., on-station or on farm research; technology evaluation; characterize yield limiting factors in order to focus technology development & evaluation; understanding interactions of management, nutrients, water; long term sustainability of soil)   main\_experiment\_factor      MAIN\_FACTOR       Main factor, factors or interactions of interest in an experiment   text
                                                                                                                                                                                                                                                                                                                       experiment\_type              EXPER\_TYPE        General type of experiment, e.g., varietal trial                    code
                                                                                                                                                                                                                                                                                                                       treatment\_name               TRT\_NAME          Treatment name                                                      text
                                                                                                                                                                                                                                                                                                                       treatment\_comments           TR\_NOTES          Treatment, extended comments on treatments                          text
  6          Information about people and institutions conducting experiments                                                                                                                                                                                                                                          persons\_notes                PERSON\_NOTES      Additional notes on persons involved with the experiment(s)         text
                                                                                                                                                                                                                                                                                                                       e\_mail\_address              EX\_EMAIL          E-mail address of researcher                                        text
                                                                                                                                                                                                                                                                                                                       institute\_name               INSTITUTION        Names of participating institutions                                 text

<span id="_Toc432333647" class="anchor"><span id="_Toc432340264"
class="anchor"><span id="_Toc432409194" class="anchor"><span
id="_Toc432428325" class="anchor"><span id="_Toc432428424"
class="anchor"></span></span></span></span></span>

### Characterization of Field Experiments (continued)

  ***B.***   <span id="RANGE!B21" class="anchor"></span>***Weather Data Required (Daily)***   ***Variable name***       ***Short Name***   ***Definition***                                                     ***Units***
  ---------- -------------------------------------------------------------------------------- ------------------------- ------------------ -------------------------------------------------------------------- -----------------
  1          Site where collected (GPS coordinates, decimal degrees)                          weather\_station\_code    WST\_ID            Weather station identifier to link to site information               text
                                                                                              weather\_station\_name    WST\_NAME          Weather station name                                                 text
                                                                                              weather\_sta\_latitude    WST\_LAT           Latitude of station, degrees decimal with North as positive value    decimal degrees
                                                                                              weather\_sta\_longitude   WST\_LONG          Longitude of station, degrees decimals with East as positive value   decimal degrees
                                                                                              weather\_sta\_elevation   WST\_ELEV          Elevation of weather station                                         m
                                                                                              temperature\_sensor\_ht   TEMHT              Weather station temperature sensor height                            m
  2-7        Observation date                                                                 weather\_date             W\_DATE            Date for daily weather, field observations, etc.                     date
  2          Minimum temperature (0C)                                                         minimum\_temperature      TMIN               Temperature of air, minimum                                          C
  3          Maximum temperature(0C)                                                          maximum\_temperature      TMAX               Temperature of air, maximum                                          C
  4          Precipitation (mm)                                                               rain\_snow\_fall          RAIN               Rainfall, including moisture in snow, in one day                     mm/d
  5          Solar radiation (MJ/m2-d)                                                        solar\_radiation          SRAD               Solar radiation                                                      MJ/m2.d
  6          Dewpoint temperature (0C) (also method of observation)                           temperature\_dewpoint     TDEW               Temperature, dewpoint                                                C
  7          Average daily wind speed (km/d)                                                  wind\_speed\_daily        WIND               Wind speed, daily                                                    km/d

It is important to have automatic weather stations collect daily weather
data in areas where experiments are to be conducted. In addition,
rainfall is needed for all sites where experiments are performed, on
farm as well as on station. Otherwise, it will not be possible to
interpret crop yield response or to understand interactions of climate,
water, nutrients and management. Temperature and solar radiation could
be measured in the areas where several experiments are conducted.
Generally, temperatures and solar radiation may change little over
distances of about 50 km, but this is not true near the coast or when
elevation changes occur in the area. One could situate a weather station
in the center of an area where experiments will be conducted on farm and
on station.

Alternatively, hourly weather data can be provided if available, such as
temperature, humidity, wind speed, precipitation, and solar radiation,
usually taken by automatic weather stations.

### Characterization of Field Experiments (continued)

  ***C.***   ***Soil Properties Data***                                                                                                         ***Variable name***            ***Short Name***   ***Definition***                                                         ***Units***
  ---------- ---------------------------------------------------------------------------------------------------------------------------------- ------------------------------ ------------------ ------------------------------------------------------------------------ ---------------------
  1          Location of soil data (GPS coordinates)                                                                                            name\_of\_soil\_profile        SOIL\_NAME         Name of soil profile                                                     text
                                                                                                                                                latitude\_soil\_profile        SOIL\_LAT          Latitude of soil profile site                                            decimal degrees
                                                                                                                                                longitude\_soil\_profile       SOIL\_LONG         Longitude of soil profile site                                           decimal degrees
                                                                                                                                                soil\_site\_elevation          SOIL\_ELEV         Elevation of soil profile site                                           m
                                                                                                                                                soil\_source                   SL\_SOURCE         Source of soil data                                                      text
  **2**      **Soil surface information **
  2a.        Soil classification (taxonomy)                                                                                                     soil\_classific\_system        SL\_SYSTEM         Soil classification system (e.g., FAO, USDA)                             text
                                                                                                                                                soil\_classification           CLASSIFICATION     Soil classification                                                      text
  2b.        Soil slope (%)                                                                                                                     soil\_profile\_slope           SL\_SLOPE          Slope where soil profile characterized                                   %
  2c.        Soil color                                                                                                                         soil\_surface\_color           SSCOL              Surface soil color, moist, using Munsell hue                             code
  **3**      **Soil profile data, for each soil horizon in which roots are likely to grow **
  3          Soil layer depth                                                                                                                   soil\_layer\_top\_depth        SLLT               Soil layer top depth                                                     cm
                                                                                                                                                soil\_layer\_base\_depth       SLLB               Soil layer base depth                                                    cm
  3a.        Soil texture (% sand, silt, clay)                                                                                                  soil\_clay\_fraction           SLCLY              Soil texture, clay (&lt;0.002 mm), weight percent of fine earth          %
                                                                                                                                                soil\_silt\_fraction           SLSIL              Soil texture, silt (0.05 to 0.002 mm), weight percent of fine earth      %
                                                                                                                                                soil\_sand\_fraction           SLSND              Soil texture, sand (0.05 to 2.0 mm), weight percent of fine earth        %
  3b.        Stones (%)                                                                                                                         soil\_coarse\_fraction         SLCF               Soil texture, coarse fraction (&gt;2 mm), weight percent of fine earth   %
  3c.        Soil organic carbon (%C)                                                                                                           soil\_organic\_C\_perc\_layr   SLOC               Total soil organic carbon by layer                                       g\[C\]/100g\[soil\]
  3d.        Bulk density (g\[soil\]/cm3)                                                                                                       soil\_bulk\_density\_moist     SLBDM              Soil bulk density when moist for layer                                   g/cm3
  3e.        LL (wilting point soil water content) and DUL (Field capacity) measurements are desirable (may have to estimate these) (mm3/mm3)   soil\_water\_lower\_limit      SLLL               Soil water, lower limit                                                  cm3/cm3
                                                                                                                                                soil\_wat\_drned\_upper\_lim   SLDUL              Soil water, drained upper limit                                          cm3/cm3
  3f.        Hydraulic conductivity (cm/h)                                                                                                      sat\_hydraul\_conductivity     SKSAT              Saturated hydraulic conductivity                                         cm/h
  **4**      **Initial soil conditions **
  4          Date of initial conditions measurement                                                                                             initial\_conditions\_date      ICDAT              Initial conditions measurement date                                      date
  4a-c.      Soil layer depth for initial conditions measurement                                                                                soil\_layer\_top\_depth        ICTL               Soil layer top depth                                                     cm
                                                                                                                                                soil\_layer\_base\_depth       ICBL               Soil layer base depth                                                    cm
  4a.        Initial soil water (mm3/mm3)                                                                                                       initial\_watr\_conc\_by\_lyr   ICH2O              Initial water concentration by layer                                     unitless
  4b.        Initial nutrients (NO3, NH4, P) and soil C by layer (ppm)                                                                          initial\_NH4\_concen\_layer    ICNH4              Initial NH4 conc., as elemental N on dry wt. basis, by layer             ppm
                                                                                                                                                initial\_NO3\_concen\_layer    ICNO3              Initial NO3 conc., as elemental N on dry wt. basis, by layer             ppm
                                                                                                                                                soil\_anal\_meth\_P\_extract   SAMPX              Soil analysis method for P extraction                                    code
                                                                                                                                                phosphorus\_extractable        SAPX               Phosphorus, extractable                                                  mg/kg
  4c.        Soil pH by layer                                                                                                                   soil\_pH\_in\_water            SLPHW              pH of soil in water, from profile description                            number
  4d.        Surface residues from previous crop (crop type, amount of residue remaining, %N, P in residue)                                     residue\_nature\_prev\_crop    ICPCR              Residue, crop code for previous crop                                     code
                                                                                                                                                residue\_above\_ground\_wt     ICRAG              Residue above-ground weight, dry weight basis                            kg/ha
                                                                                                                                                residue\_N\_conc               ICRN               Residue, above-ground, nitrogen concentration                            %
                                                                                                                                                residue\_P\_conc               ICRP               Residue, above-ground, phosphorus concentration                          %
                                                                                                                                                residue\_K\_conc               ICRK               Residue, above-ground, potassium concentration                           %

<span id="_Toc432333649" class="anchor"><span id="_Toc432340266"
class="anchor"><span id="_Toc432409196" class="anchor"><span
id="_Toc432428327" class="anchor"><span id="_Toc432428426"
class="anchor"></span></span></span></span></span>

### Characterization of Field Experiments (continued)

  ***D.***   ***Management Data***                                                                                                                                                                                           ***Variable name***           ***Short Name***   ***Definition***                                                  ***Units***
  ---------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------- ------------------ ----------------------------------------------------------------- -------------
  **1**      **Planting **
  1a.        Planting date                                                                                                                                                                                                   planting\_date                PDATE              Planting or sowing date                                           date
  1b.        Crop, cultivar name and characteristics                                                                                                                                                                         crop\_ident\_ICASA            CRID               Crop (or weed) species identifier                                 code
                                                                                                                                                                                                                             cultivar\_identifier          CUL\_ID            Cultivar, line or genotype identifier                             code
                                                                                                                                                                                                                             relative\_maturity            RM                 Relative maturity                                                 days
                                                                                                                                                                                                                             cultivar\_name                CUL\_NAME          Cultivar name                                                     text
                                                                                                                                                                                                                             cultivar\_notes               CUL\_NOTES         Cultivar notes                                                    text
  1c.        Row spacing (cm)                                                                                                                                                                                                row\_spacing                  PLRS               Row spacing                                                       cm
  1d.        Plant density (plants per m2)                                                                                                                                                                                   plant\_pop\_at\_planting      PLPOP              Plant population at planting                                      number/m2
                                                                                                                                                                                                                             plant\_pop\_at\_emergence     PLPOE              Plant population at emergence                                     number/m2
  1e.        Planting mode (row, hill, flat, ridge, etc.)                                                                                                                                                                    planting\_material            PLMA               Planting material                                                 code
                                                                                                                                                                                                                             planting\_distribution        PLDS               Planting distribution                                             code
  **2**      **Irrigation system type (sprinkler, drip, furrow, subsurface) **
  2a.        Date                                                                                                                                                                                                            irrigation\_date              IDATE              Irrigation date                                                   date
  2b.        Irrigation type                                                                                                                                                                                                 irrigation\_operation         IROP               Irrigation operation (e.g., furrow, sprinkler, drip…)             code
  2c.        amounts of irrigation, each application date                                                                                                                                                                    irrig\_amount\_depth          IRVAL              Irrigation amount, depth of water                                 mm
  **3**      **Fertilizer application **
  3a.        Date                                                                                                                                                                                                            fertilization\_date           FEDATE             Fertilization date                                                date
  3b.        Type of fertilizer                                                                                                                                                                                              fertilizer\_material          FECD               Fertilizer material                                               code
  3c.        Application method                                                                                                                                                                                              fertilizer\_applic\_method    FEACD              Fertilizer application method                                     code
                                                                                                                                                                                                                             application\_depth\_fert      FEDEP              Fertilizer application depth                                      cm
  3d.        Amount N, P, K applied, each date of application (kg/ha)                                                                                                                                                        N\_in\_applied\_fertilizer    FEAMN              Nitrogen in applied fertilizer                                    kg\[N\]/ha
                                                                                                                                                                                                                             phosphorus\_applied\_fert     FEAMP              Phosphorus in applied fertilizer                                  kg\[P\]/ha
                                                                                                                                                                                                                             fertilizer\_K\_applied        FEAMK              Potassium in applied fertilizer                                   kg\[K\]/ha
  **4**      **Organic matter application (crop residue or manure) **
  4a.        Date                                                                                                                                                                                                            org\_material\_applic\_date   OMDAT              Organic materials application date                                date
  4b.        Organic matter type and quality                                                                                                                                                                                 organic\_material             OMCD               Organic material, identifying code                                code
  4c.        amount added, incorporation depth and %                                                                                                                                                                         org\_material\_applic\_amnt   OMAMT              Organic materials application amount, dry weight basis            kg/ha
                                                                                                                                                                                                                             org\_material\_appl\_depth    OMDEP              Organic materials application depth                               cm
                                                                                                                                                                                                                             org\_material\_incorp\_perc   OMINP              Organic materials application, fraction incorporated as percent   %
  4d.        %N, %C, and %P contents                                                                                                                                                                                         org\_matter\_carbon\_conc     OMC%               Organic matter or residue added, carbon concentration             %
                                                                                                                                                                                                                             organic\_material\_N\_conc    OMN%               Organic materials nitrogen concentration                          %
                                                                                                                                                                                                                             organic\_material\_P\_conc    OMP%               Organic materials phosphorus concentration                        %
  4e.        % ground covered by organic matter at planting                                                                                                                                                                  org\_material\_cover          OMCOV              Organic materials, percent ground covered by organic matter       %
  **5**      **Tillage **
  5a.        Date                                                                                                                                                                                                            tillage\_date                 TDATE              Tillage date                                                      date
  5b.        Tillage implement                                                                                                                                                                                               tillage\_implement            TIIMP              Tillage implement                                                 code
  5c.        Tillage depth                                                                                                                                                                                                   tillage\_operations\_depth    TIDEP              Tillage operations depth                                          cm
  **6**      **Harvest operations **
  6a.        Date                                                                                                                                                                                                            harvest\_operations\_date     HADAT              Harvest operations date                                           date
  6b.        Crop component harvested                                                                                                                                                                                        harvest\_operat\_component    HACOM              Harvest operations, crop component harvested                      code
  6c.        Harvest method                                                                                                                                                                                                  harvest\_method               HARM               Harvest method                                                    code
  6d.        Percent of yield component removed from field                                                                                                                                                                   harv\_operat\_main\_product   HAP%               Harvest operations, percent economic product harvested            %
  6e.        Percent of byproduct removed from field                                                                                                                                                                         harv\_operation\_byproduct    HAB%               Harvest operations, percent of by-product harvested               %
  **7**      **Chemical applications**                                                                                                                                                                                                                                                                                                           
  7          Chemicals applied: dates, material applied, rate, and for what purposes. For all, give fallow management before current crop, including whether the soil was kept bare or whether weeds were allowed to grow.   chemical\_applic\_date        CDATE              Chemicals application date                                        date
                                                                                                                                                                                                                             chemical\_applic\_material    CHCD               Chemicals application material                                    code
                                                                                                                                                                                                                             chemical\_applic\_method      CHACD              Chemicals application method                                      code
                                                                                                                                                                                                                             application\_depth\_chem      CHDEP              Chemicals application depth                                       cm
                                                                                                                                                                                                                             chemical\_applic\_amount      CHAMT              Chemicals application amount (active)                             kg/ha
                                                                                                                                                                                                                             chemical\_applic\_target      CH\_TARGETS        Chemicals application target                                      code

<span id="_Toc432333650" class="anchor"><span id="_Toc432340267"
class="anchor"><span id="_Toc432409197" class="anchor"><span
id="_Toc432428328" class="anchor"><span id="_Toc432428427"
class="anchor"></span></span></span></span></span>

### Measurements of Crop and Soil Responses 

The amount of crop response data varies considerably depending on
purposes of the researchers, and resource constraints. The list here
includes data recorded in a range of research, varying from yield or
variety trials to research comparing effects of different management
practices on yield, resource use efficiency, and residual agrochemicals.
Note that one should record dates of all measurements that are made,
whether final or in-season.

  ***A.***   ***Measurements recorded once per growing season***                             ***Variable name***           ***Short Name***   ***Definition***                                                   ***Units***
  ---------- ------------------------------------------------------------------------------- ----------------------------- ------------------ ------------------------------------------------------------------ -------------
  **1**      **Crop developmental stages **
  1a.        Anthesis (flowering) date                                                       anthesis\_date                ADAT               Growth stage date, anthesis                                        date
  1b.        Time of first seed, date                                                        beginning\_seed\_stage        R5AT               Growth stage date, beginning seed                                  date
  1c.        Physiological maturity date                                                     physiologic\_maturity\_dat    MDAT               Growth stage of physiol. maturity, as date                         date
  1d.        Harvest maturity, days after planting                                           harvest\_maturity\_dap        R8AP               Growth stage days&gt;planting, harv mature                         dap
  **2**      **Final yield and yield components at harvest (give date of harvest) **
  2a.        Harvest date                                                                    harvest\_date                 HDATE              Growth stage date, harvest                                         date
  2b.        Harvest yield dry weight (kg/ha)                                                harvest\_yield\_harvest\_dw   HWAH               Harvested yield at harvest (dry wt)                                kg/ha
  2c.        Number of ears, pods, or other fruiting structures per unit land area (\#/m2)   pod\_number\_maturity         PD\#AM             Pod number at maturity                                             number/m2
                                                                                             panicle\_number\_maturity     PN\#AM             Panicle number at maturity                                         number/m2
                                                                                             tiller\_number\_maturity      T\#AM              Tiller number at maturity                                          number/m2
  2d.        Average weight per fruiting structure (g/unit)                                  unit\_dry\_wt\_harv\_matur    HWUM               Harvest unit dry (e.g., seed) weight at harv. maturity             g/unit
  2e.        Average number of seed per fruiting structure                                   harv\_no\_per\_unit           H\#UM              Harvest number per unit at maturity                                number
  2f.        N concentrations of grain or fruiting structure, leaves, branches               tops\_N\_at\_maturity         CNAM               Nitrogen in above ground plant parts at maturity                   kg/ha
                                                                                             grain\_N\_at\_maturity        GNAM               Grain N at maturity                                                kg/ha
                                                                                             grain\_N\_conc\_maturity      GN%M               Grain N concentration at maturity                                  %
  2g.        Number of main stem nodes                                                       leaf\_no\_per\_stem\_matur    L\#SM              Leaf number per stem, at harvest maturity                          number
  2h.        Plant density at harvest                                                        plant\_density\_maturity      PLPAM              Plant density at maturity                                          \#/m2
  2i.        Total above ground biomass, including fruiting structure                        tops\_dry\_weight\_harvest    CWAH               Tops dry weight at harvest                                         kg/ha
  ***B.***   ***Measurements Recorded Multiple Times per Growing Season ***                  ***Variable name***           ***Short Name***   ***Definition***                                                   ***Units***
  **1**      **Crop measurements **
  1a.        Dates of measurement                                                            date\_of\_measurement         DATE               Date of measurement                                                date
  1b.        Total aboveground biomass                                                       tops\_dry\_weight             CWAD               Tops dry weight                                                    kg/ha
  1c.        Grain weight                                                                    grain\_dry\_weight            GWAD               Grain dry weight                                                   kg/ha
                                                                                             tuber\_dry\_weight            UWAD               Tuber dry weight                                                   kg/ha
  1d.        Leaf, stem, and ear (pod) weights                                               leaf\_dry\_weight             LWAD               Leaf dry weight                                                    kg/ha
                                                                                             stem\_dry\_weight             SWAD               Stem dry weight                                                    kg/ha
                                                                                             panicle\_weight               PNAD               Panicle weight (grain+structural)                                  kg/ha
                                                                                             pod\_dry\_weight              PWAD               Pod dry weight                                                     kg/ha
                                                                                             ear\_grain\_chaff\_dry\_wt    EWAD               Ear (grain+chaff) dry weight                                       kg/ha
  1e.        Number of mainstem leaves                                                       leaf\_number\_per\_stem       L\#SD              Leaf number per stem                                               number
  1f.        Leaf area index                                                                 leaf\_area\_index             LAID               Leaf area index                                                    m2/m2
  1g.        N concentrations in vegetative and reproductive plant parts                     tops\_N\_concentration        CN%D               Tops (i.e., canopy) N concentration                                %
                                                                                             grain\_N\_conc                GN%D               Grain N concentration                                              %
                                                                                             leaf\_N\_concentration        LN%D               Leaf N concentration                                               %
  1h.        Numbers of ears (pods or seeds) per m2                                          ear\_number                   E\#AD              Ear number                                                         number/m2
                                                                                             grain\_number                 G\#AD              Grain number                                                       number/m2
                                                                                             pod\_number                   PD\#AD             Pod number                                                         number/m2
                                                                                             panicle\_number               PN\#AD             Panicle number                                                     number/m2
  **2**      **Soil water & nutrient status **
  2a.        Dates of measurement or observation, depths for soil layer information (cm)     date\_of\_measurement         DATE               Date of measurement                                                date
                                                                                             soil\_layer\_top\_depth       SLDUB              Soil layer depth to upper boundary of sample (top)                 cm
                                                                                             soil\_layer\_bot\_depth       SLDLB              Soil layer depth to lower boundary of sample (bottom)              cm
  2b.        Soil water content vs. depth (TDR, Neutron probe, etc) (mm3/mm3)                soil\_water\_by\_layer        SWLD               Soil water measured at a specified depth                           cm3/cm3
  2c.        Analysis for NO3-N and NH4-N (ppm) for soil layers and sampling times           NO3\_soil\_by\_layer          NOSLD              NO3\[N\], for a given soil layer                                   g/Mg
                                                                                             NH4\_soil\_by\_layer          NHSLD              NH4\[N\], for a given soil layer                                   g/Mg
  2d.        Evaporation, transpiration, or evapotranspiration (mm)                          transpiration\_daily          EPAD               Transpiration (evaporation from plant), daily                      mm/d
                                                                                             transpiration\_cumulative     EPAC               Transpiration, cumulative over season                              mm
                                                                                             soil\_evaporation\_daily      ESAD               Evaporation, soil, daily                                           mm/d
                                                                                             soil\_evap\_cumulative        ESAC               Evaporation, soil, cumulative                                      mm
                                                                                             evapotranspiration\_daily     ETAD               Evapotranspiration                                                 mm/d
                                                                                             evapotransp\_cumulative       ETAC               Evapotranspiration, cumulative over season                         mm
  2e.        Surface runoff amount (mm)                                                      runoff\_surface               ROFD               Runoff, surface                                                    mm/d
                                                                                             runoff\_cumulative            ROFC               Runoff, cumulative                                                 mm
  2f.        Drainage amount (mm)                                                            drainage\_cumulative          DRNC               Drainage, cumulative                                               mm
  **3**      **Plant health status **
  3a.        Dates of observations                                                           date\_of\_measurement         DATE               Date of measurement                                                date
  3b.        Plant wilting indication                                                        water\_stress\_growth         WSGD               Water stress - growth (0 to 1 scale)                               number
  3c.        Foliage temperature                                                             canopy\_temp\_daily\_avg      TGAV               Temperature, daily canopy average                                  C
  **3d.**    **Observed pest damage **
  3d.i.      Dates of measurement or observation                                             date\_of\_measurement         DATE               Date of measurement                                                date
  3d.ii.     Insect, disease or weed types                                                   field\_notes                  FL\_NOTES          Field, short notes                                                 text
  3d.iii     Insects or disease, occurrence, intensity, damage                               plant\_pop\_reduct\_cum       CPO%               Plant population reduction, cumulative                             %
                                                                                             leaf\_mass\_consumed\_cumu    CLFM               Leaf mass consumed, cumulative                                     kg/ha
                                                                                             root\_mass\_consum\_cumul     CRTM               Root mass consumed, cumulative                                     kg/ha
                                                                                             grain\_mass\_consum\_cumul    CSDM               Grain mass consumed, cumulative                                    kg/ha
                                                                                             shell\_mass\_consum\_cumul    CSHM               Shell mass consumed, cumulative                                    kg/ha
                                                                                             stem\_mass\_consum\_cumul     CSTM               Stem mass consumed, cumulative                                     kg/ha
                                                                                             leaf\_area\_consumed\_cumu    CLAI               Leaf area consumed or destroyed by pests or diseases, cumulative   m2/m2
                                                                                             grain\_numb\_consum\_cumul    CSD\#              Grain number consumed, cumulative                                  number/m2
                                                                                             shell\_numb\_consum\_cumul    CSH\#              Shell number consumed, cumulative                                  number/m2
                                                                                             lodging\_percent              LDG%D              Percent lodging                                                    %


