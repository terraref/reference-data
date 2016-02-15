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
  1          Location of experiment (GPS coordinates, on station, on farm)                                                                                                                                                                                                                                             experiment_name_local       LOCAL_NAME        Locally used name for experiment                                    text
                                                                                                                                                                                                                                                                                                                       site_name                    SITE_NAME         Name of site for experiment                                         text
                                                                                                                                                                                                                                                                                                                       field_latitude               FL_LAT            Field latitude                                                      decimal degrees
                                                                                                                                                                                                                                                                                                                       field_longitude              FL_LONG           Field longitude, E positive, W negative                             decimal degrees
  2          Physical attributes of field (area, slope)                                                                                                                                                                                                                                                                field_area                   FAREA              Field area                                                          m2
                                                                                                                                                                                                                                                                                                                       field_length_width_ratio   FLLWR              Field length to width ratio                                         number
                                                                                                                                                                                                                                                                                                                       field_slope                  FLSL               Field slope (from horizontal)                                       percent
  3          Drainage characteristics                                                                                                                                                                                                                                                                                  drainage_type                FL_DRNTYPE        Drainage, type in field                                             code
  4          Water table depth                                                                                                                                                                                                                                                                                         water_table_depth           DTWT               Water table depth                                                   cm
  5          General purposes of experiments (descriptive text e.g., on-station or on farm research; technology evaluation; characterize yield limiting factors in order to focus technology development & evaluation; understanding interactions of management, nutrients, water; long term sustainability of soil)   main_experiment_factor      MAIN_FACTOR       Main factor, factors or interactions of interest in an experiment   text
                                                                                                                                                                                                                                                                                                                       experiment_type              EXPER_TYPE        General type of experiment, e.g., varietal trial                    code
                                                                                                                                                                                                                                                                                                                       treatment_name               TRT_NAME          Treatment name                                                      text
                                                                                                                                                                                                                                                                                                                       treatment_comments           TR_NOTES          Treatment, extended comments on treatments                          text
  6          Information about people and institutions conducting experiments                                                                                                                                                                                                                                          persons_notes                PERSON_NOTES      Additional notes on persons involved with the experiment(s)         text
                                                                                                                                                                                                                                                                                                                       e_mail_address              EX_EMAIL          E-mail address of researcher                                        text
                                                                                                                                                                                                                                                                                                                       institute_name               INSTITUTION        Names of participating institutions                                 text

<span id="_Toc432333647" class="anchor"><span id="_Toc432340264"
class="anchor"><span id="_Toc432409194" class="anchor"><span
id="_Toc432428325" class="anchor"><span id="_Toc432428424"
class="anchor"></span></span></span></span></span>

### Characterization of Field Experiments (continued)

  ***B.***   <span id="RANGE!B21" class="anchor"></span>***Weather Data Required (Daily)***   ***Variable name***       ***Short Name***   ***Definition***                                                     ***Units***
  ---------- -------------------------------------------------------------------------------- ------------------------- ------------------ -------------------------------------------------------------------- -----------------
  1          Site where collected (GPS coordinates, decimal degrees)                          weather_station_code    WST_ID            Weather station identifier to link to site information               text
                                                                                              weather_station_name    WST_NAME          Weather station name                                                 text
                                                                                              weather_sta_latitude    WST_LAT           Latitude of station, degrees decimal with North as positive value    decimal degrees
                                                                                              weather_sta_longitude   WST_LONG          Longitude of station, degrees decimals with East as positive value   decimal degrees
                                                                                              weather_sta_elevation   WST_ELEV          Elevation of weather station                                         m
                                                                                              temperature_sensor_ht   TEMHT              Weather station temperature sensor height                            m
  2-7        Observation date                                                                 weather_date             W_DATE            Date for daily weather, field observations, etc.                     date
  2          Minimum temperature (0C)                                                         minimum_temperature      TMIN               Temperature of air, minimum                                          C
  3          Maximum temperature(0C)                                                          maximum_temperature      TMAX               Temperature of air, maximum                                          C
  4          Precipitation (mm)                                                               rain_snow_fall          RAIN               Rainfall, including moisture in snow, in one day                     mm/d
  5          Solar radiation (MJ/m2-d)                                                        solar_radiation          SRAD               Solar radiation                                                      MJ/m2.d
  6          Dewpoint temperature (0C) (also method of observation)                           temperature_dewpoint     TDEW               Temperature, dewpoint                                                C
  7          Average daily wind speed (km/d)                                                  wind_speed_daily        WIND               Wind speed, daily                                                    km/d

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
  1          Location of soil data (GPS coordinates)                                                                                            name_of_soil_profile        SOIL_NAME         Name of soil profile                                                     text
                                                                                                                                                latitude_soil_profile        SOIL_LAT          Latitude of soil profile site                                            decimal degrees
                                                                                                                                                longitude_soil_profile       SOIL_LONG         Longitude of soil profile site                                           decimal degrees
                                                                                                                                                soil_site_elevation          SOIL_ELEV         Elevation of soil profile site                                           m
                                                                                                                                                soil_source                   SL_SOURCE         Source of soil data                                                      text
  **2**      **Soil surface information **
  2a.        Soil classification (taxonomy)                                                                                                     soil_classific_system        SL_SYSTEM         Soil classification system (e.g., FAO, USDA)                             text
                                                                                                                                                soil_classification           CLASSIFICATION     Soil classification                                                      text
  2b.        Soil slope (%)                                                                                                                     soil_profile_slope           SL_SLOPE          Slope where soil profile characterized                                   %
  2c.        Soil color                                                                                                                         soil_surface_color           SSCOL              Surface soil color, moist, using Munsell hue                             code
  **3**      **Soil profile data, for each soil horizon in which roots are likely to grow **
  3          Soil layer depth                                                                                                                   soil_layer_top_depth        SLLT               Soil layer top depth                                                     cm
                                                                                                                                                soil_layer_base_depth       SLLB               Soil layer base depth                                                    cm
  3a.        Soil texture (% sand, silt, clay)                                                                                                  soil_clay_fraction           SLCLY              Soil texture, clay (&lt;0.002 mm), weight percent of fine earth          %
                                                                                                                                                soil_silt_fraction           SLSIL              Soil texture, silt (0.05 to 0.002 mm), weight percent of fine earth      %
                                                                                                                                                soil_sand_fraction           SLSND              Soil texture, sand (0.05 to 2.0 mm), weight percent of fine earth        %
  3b.        Stones (%)                                                                                                                         soil_coarse_fraction         SLCF               Soil texture, coarse fraction (&gt;2 mm), weight percent of fine earth   %
  3c.        Soil organic carbon (%C)                                                                                                           soil_organic_C_perc_layr   SLOC               Total soil organic carbon by layer                                       g[C]/100g[soil]
  3d.        Bulk density (g[soil]/cm3)                                                                                                       soil_bulk_density_moist     SLBDM              Soil bulk density when moist for layer                                   g/cm3
  3e.        LL (wilting point soil water content) and DUL (Field capacity) measurements are desirable (may have to estimate these) (mm3/mm3)   soil_water_lower_limit      SLLL               Soil water, lower limit                                                  cm3/cm3
                                                                                                                                                soil_wat_drned_upper_lim   SLDUL              Soil water, drained upper limit                                          cm3/cm3
  3f.        Hydraulic conductivity (cm/h)                                                                                                      sat_hydraul_conductivity     SKSAT              Saturated hydraulic conductivity                                         cm/h
  **4**      **Initial soil conditions **
  4          Date of initial conditions measurement                                                                                             initial_conditions_date      ICDAT              Initial conditions measurement date                                      date
  4a-c.      Soil layer depth for initial conditions measurement                                                                                soil_layer_top_depth        ICTL               Soil layer top depth                                                     cm
                                                                                                                                                soil_layer_base_depth       ICBL               Soil layer base depth                                                    cm
  4a.        Initial soil water (mm3/mm3)                                                                                                       initial_watr_conc_by_lyr   ICH2O              Initial water concentration by layer                                     unitless
  4b.        Initial nutrients (NO3, NH4, P) and soil C by layer (ppm)                                                                          initial_NH4_concen_layer    ICNH4              Initial NH4 conc., as elemental N on dry wt. basis, by layer             ppm
                                                                                                                                                initial_NO3_concen_layer    ICNO3              Initial NO3 conc., as elemental N on dry wt. basis, by layer             ppm
                                                                                                                                                soil_anal_meth_P_extract   SAMPX              Soil analysis method for P extraction                                    code
                                                                                                                                                phosphorus_extractable        SAPX               Phosphorus, extractable                                                  mg/kg
  4c.        Soil pH by layer                                                                                                                   soil_pH_in_water            SLPHW              pH of soil in water, from profile description                            number
  4d.        Surface residues from previous crop (crop type, amount of residue remaining, %N, P in residue)                                     residue_nature_prev_crop    ICPCR              Residue, crop code for previous crop                                     code
                                                                                                                                                residue_above_ground_wt     ICRAG              Residue above-ground weight, dry weight basis                            kg/ha
                                                                                                                                                residue_N_conc               ICRN               Residue, above-ground, nitrogen concentration                            %
                                                                                                                                                residue_P_conc               ICRP               Residue, above-ground, phosphorus concentration                          %
                                                                                                                                                residue_K_conc               ICRK               Residue, above-ground, potassium concentration                           %

<span id="_Toc432333649" class="anchor"><span id="_Toc432340266"
class="anchor"><span id="_Toc432409196" class="anchor"><span
id="_Toc432428327" class="anchor"><span id="_Toc432428426"
class="anchor"></span></span></span></span></span>

### Characterization of Field Experiments (continued)

  ***D.***   ***Management Data***                                                                                                                                                                                           ***Variable name***           ***Short Name***   ***Definition***                                                  ***Units***
  ---------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------- ------------------ ----------------------------------------------------------------- -------------
  **1**      **Planting **
  1a.        Planting date                                                                                                                                                                                                   planting_date                PDATE              Planting or sowing date                                           date
  1b.        Crop, cultivar name and characteristics                                                                                                                                                                         crop_ident_ICASA            CRID               Crop (or weed) species identifier                                 code
                                                                                                                                                                                                                             cultivar_identifier          CUL_ID            Cultivar, line or genotype identifier                             code
                                                                                                                                                                                                                             relative_maturity            RM                 Relative maturity                                                 days
                                                                                                                                                                                                                             cultivar_name                CUL_NAME          Cultivar name                                                     text
                                                                                                                                                                                                                             cultivar_notes               CUL_NOTES         Cultivar notes                                                    text
  1c.        Row spacing (cm)                                                                                                                                                                                                row_spacing                  PLRS               Row spacing                                                       cm
  1d.        Plant density (plants per m2)                                                                                                                                                                                   plant_pop_at_planting      PLPOP              Plant population at planting                                      number/m2
                                                                                                                                                                                                                             plant_pop_at_emergence     PLPOE              Plant population at emergence                                     number/m2
  1e.        Planting mode (row, hill, flat, ridge, etc.)                                                                                                                                                                    planting_material            PLMA               Planting material                                                 code
                                                                                                                                                                                                                             planting_distribution        PLDS               Planting distribution                                             code
  **2**      **Irrigation system type (sprinkler, drip, furrow, subsurface) **
  2a.        Date                                                                                                                                                                                                            irrigation_date              IDATE              Irrigation date                                                   date
  2b.        Irrigation type                                                                                                                                                                                                 irrigation_operation         IROP               Irrigation operation (e.g., furrow, sprinkler, drip…)             code
  2c.        amounts of irrigation, each application date                                                                                                                                                                    irrig_amount_depth          IRVAL              Irrigation amount, depth of water                                 mm
  **3**      **Fertilizer application **
  3a.        Date                                                                                                                                                                                                            fertilization_date           FEDATE             Fertilization date                                                date
  3b.        Type of fertilizer                                                                                                                                                                                              fertilizer_material          FECD               Fertilizer material                                               code
  3c.        Application method                                                                                                                                                                                              fertilizer_applic_method    FEACD              Fertilizer application method                                     code
                                                                                                                                                                                                                             application_depth_fert      FEDEP              Fertilizer application depth                                      cm
  3d.        Amount N, P, K applied, each date of application (kg/ha)                                                                                                                                                        N_in_applied_fertilizer    FEAMN              Nitrogen in applied fertilizer                                    kg[N]/ha
                                                                                                                                                                                                                             phosphorus_applied_fert     FEAMP              Phosphorus in applied fertilizer                                  kg[P]/ha
                                                                                                                                                                                                                             fertilizer_K_applied        FEAMK              Potassium in applied fertilizer                                   kg[K]/ha
  **4**      **Organic matter application (crop residue or manure) **
  4a.        Date                                                                                                                                                                                                            org_material_applic_date   OMDAT              Organic materials application date                                date
  4b.        Organic matter type and quality                                                                                                                                                                                 organic_material             OMCD               Organic material, identifying code                                code
  4c.        amount added, incorporation depth and %                                                                                                                                                                         org_material_applic_amnt   OMAMT              Organic materials application amount, dry weight basis            kg/ha
                                                                                                                                                                                                                             org_material_appl_depth    OMDEP              Organic materials application depth                               cm
                                                                                                                                                                                                                             org_material_incorp_perc   OMINP              Organic materials application, fraction incorporated as percent   %
  4d.        %N, %C, and %P contents                                                                                                                                                                                         org_matter_carbon_conc     OMC%               Organic matter or residue added, carbon concentration             %
                                                                                                                                                                                                                             organic_material_N_conc    OMN%               Organic materials nitrogen concentration                          %
                                                                                                                                                                                                                             organic_material_P_conc    OMP%               Organic materials phosphorus concentration                        %
  4e.        % ground covered by organic matter at planting                                                                                                                                                                  org_material_cover          OMCOV              Organic materials, percent ground covered by organic matter       %
  **5**      **Tillage **
  5a.        Date                                                                                                                                                                                                            tillage_date                 TDATE              Tillage date                                                      date
  5b.        Tillage implement                                                                                                                                                                                               tillage_implement            TIIMP              Tillage implement                                                 code
  5c.        Tillage depth                                                                                                                                                                                                   tillage_operations_depth    TIDEP              Tillage operations depth                                          cm
  **6**      **Harvest operations **
  6a.        Date                                                                                                                                                                                                            harvest_operations_date     HADAT              Harvest operations date                                           date
  6b.        Crop component harvested                                                                                                                                                                                        harvest_operat_component    HACOM              Harvest operations, crop component harvested                      code
  6c.        Harvest method                                                                                                                                                                                                  harvest_method               HARM               Harvest method                                                    code
  6d.        Percent of yield component removed from field                                                                                                                                                                   harv_operat_main_product   HAP%               Harvest operations, percent economic product harvested            %
  6e.        Percent of byproduct removed from field                                                                                                                                                                         harv_operation_byproduct    HAB%               Harvest operations, percent of by-product harvested               %
  **7**      **Chemical applications**                                                                                                                                                                                                                                                                                                           
  7          Chemicals applied: dates, material applied, rate, and for what purposes. For all, give fallow management before current crop, including whether the soil was kept bare or whether weeds were allowed to grow.   chemical_applic_date        CDATE              Chemicals application date                                        date
                                                                                                                                                                                                                             chemical_applic_material    CHCD               Chemicals application material                                    code
                                                                                                                                                                                                                             chemical_applic_method      CHACD              Chemicals application method                                      code
                                                                                                                                                                                                                             application_depth_chem      CHDEP              Chemicals application depth                                       cm
                                                                                                                                                                                                                             chemical_applic_amount      CHAMT              Chemicals application amount (active)                             kg/ha
                                                                                                                                                                                                                             chemical_applic_target      CH_TARGETS        Chemicals application target                                      code

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
  1a.        Anthesis (flowering) date                                                       anthesis_date                ADAT               Growth stage date, anthesis                                        date
  1b.        Time of first seed, date                                                        beginning_seed_stage        R5AT               Growth stage date, beginning seed                                  date
  1c.        Physiological maturity date                                                     physiologic_maturity_dat    MDAT               Growth stage of physiol. maturity, as date                         date
  1d.        Harvest maturity, days after planting                                           harvest_maturity_dap        R8AP               Growth stage days&gt;planting, harv mature                         dap
  **2**      **Final yield and yield components at harvest (give date of harvest) **
  2a.        Harvest date                                                                    harvest_date                 HDATE              Growth stage date, harvest                                         date
  2b.        Harvest yield dry weight (kg/ha)                                                harvest_yield_harvest_dw   HWAH               Harvested yield at harvest (dry wt)                                kg/ha
  2c.        Number of ears, pods, or other fruiting structures per unit land area (#/m2)   pod_number_maturity         PD#AM             Pod number at maturity                                             number/m2
                                                                                             panicle_number_maturity     PN#AM             Panicle number at maturity                                         number/m2
                                                                                             tiller_number_maturity      T#AM              Tiller number at maturity                                          number/m2
  2d.        Average weight per fruiting structure (g/unit)                                  unit_dry_wt_harv_matur    HWUM               Harvest unit dry (e.g., seed) weight at harv. maturity             g/unit
  2e.        Average number of seed per fruiting structure                                   harv_no_per_unit           H#UM              Harvest number per unit at maturity                                number
  2f.        N concentrations of grain or fruiting structure, leaves, branches               tops_N_at_maturity         CNAM               Nitrogen in above ground plant parts at maturity                   kg/ha
                                                                                             grain_N_at_maturity        GNAM               Grain N at maturity                                                kg/ha
                                                                                             grain_N_conc_maturity      GN%M               Grain N concentration at maturity                                  %
  2g.        Number of main stem nodes                                                       leaf_no_per_stem_matur    L#SM              Leaf number per stem, at harvest maturity                          number
  2h.        Plant density at harvest                                                        plant_density_maturity      PLPAM              Plant density at maturity                                          #/m2
  2i.        Total above ground biomass, including fruiting structure                        tops_dry_weight_harvest    CWAH               Tops dry weight at harvest                                         kg/ha
  ***B.***   ***Measurements Recorded Multiple Times per Growing Season ***                  ***Variable name***           ***Short Name***   ***Definition***                                                   ***Units***
  **1**      **Crop measurements **
  1a.        Dates of measurement                                                            date_of_measurement         DATE               Date of measurement                                                date
  1b.        Total aboveground biomass                                                       tops_dry_weight             CWAD               Tops dry weight                                                    kg/ha
  1c.        Grain weight                                                                    grain_dry_weight            GWAD               Grain dry weight                                                   kg/ha
                                                                                             tuber_dry_weight            UWAD               Tuber dry weight                                                   kg/ha
  1d.        Leaf, stem, and ear (pod) weights                                               leaf_dry_weight             LWAD               Leaf dry weight                                                    kg/ha
                                                                                             stem_dry_weight             SWAD               Stem dry weight                                                    kg/ha
                                                                                             panicle_weight               PNAD               Panicle weight (grain+structural)                                  kg/ha
                                                                                             pod_dry_weight              PWAD               Pod dry weight                                                     kg/ha
                                                                                             ear_grain_chaff_dry_wt    EWAD               Ear (grain+chaff) dry weight                                       kg/ha
  1e.        Number of mainstem leaves                                                       leaf_number_per_stem       L#SD              Leaf number per stem                                               number
  1f.        Leaf area index                                                                 leaf_area_index             LAID               Leaf area index                                                    m2/m2
  1g.        N concentrations in vegetative and reproductive plant parts                     tops_N_concentration        CN%D               Tops (i.e., canopy) N concentration                                %
                                                                                             grain_N_conc                GN%D               Grain N concentration                                              %
                                                                                             leaf_N_concentration        LN%D               Leaf N concentration                                               %
  1h.        Numbers of ears (pods or seeds) per m2                                          ear_number                   E#AD              Ear number                                                         number/m2
                                                                                             grain_number                 G#AD              Grain number                                                       number/m2
                                                                                             pod_number                   PD#AD             Pod number                                                         number/m2
                                                                                             panicle_number               PN#AD             Panicle number                                                     number/m2
  **2**      **Soil water & nutrient status **
  2a.        Dates of measurement or observation, depths for soil layer information (cm)     date_of_measurement         DATE               Date of measurement                                                date
                                                                                             soil_layer_top_depth       SLDUB              Soil layer depth to upper boundary of sample (top)                 cm
                                                                                             soil_layer_bot_depth       SLDLB              Soil layer depth to lower boundary of sample (bottom)              cm
  2b.        Soil water content vs. depth (TDR, Neutron probe, etc) (mm3/mm3)                soil_water_by_layer        SWLD               Soil water measured at a specified depth                           cm3/cm3
  2c.        Analysis for NO3-N and NH4-N (ppm) for soil layers and sampling times           NO3_soil_by_layer          NOSLD              NO3[N], for a given soil layer                                   g/Mg
                                                                                             NH4_soil_by_layer          NHSLD              NH4[N], for a given soil layer                                   g/Mg
  2d.        Evaporation, transpiration, or evapotranspiration (mm)                          transpiration_daily          EPAD               Transpiration (evaporation from plant), daily                      mm/d
                                                                                             transpiration_cumulative     EPAC               Transpiration, cumulative over season                              mm
                                                                                             soil_evaporation_daily      ESAD               Evaporation, soil, daily                                           mm/d
                                                                                             soil_evap_cumulative        ESAC               Evaporation, soil, cumulative                                      mm
                                                                                             evapotranspiration_daily     ETAD               Evapotranspiration                                                 mm/d
                                                                                             evapotransp_cumulative       ETAC               Evapotranspiration, cumulative over season                         mm
  2e.        Surface runoff amount (mm)                                                      runoff_surface               ROFD               Runoff, surface                                                    mm/d
                                                                                             runoff_cumulative            ROFC               Runoff, cumulative                                                 mm
  2f.        Drainage amount (mm)                                                            drainage_cumulative          DRNC               Drainage, cumulative                                               mm
  **3**      **Plant health status **
  3a.        Dates of observations                                                           date_of_measurement         DATE               Date of measurement                                                date
  3b.        Plant wilting indication                                                        water_stress_growth         WSGD               Water stress - growth (0 to 1 scale)                               number
  3c.        Foliage temperature                                                             canopy_temp_daily_avg      TGAV               Temperature, daily canopy average                                  C
  **3d.**    **Observed pest damage **
  3d.i.      Dates of measurement or observation                                             date_of_measurement         DATE               Date of measurement                                                date
  3d.ii.     Insect, disease or weed types                                                   field_notes                  FL_NOTES          Field, short notes                                                 text
  3d.iii     Insects or disease, occurrence, intensity, damage                               plant_pop_reduct_cum       CPO%               Plant population reduction, cumulative                             %
                                                                                             leaf_mass_consumed_cumu    CLFM               Leaf mass consumed, cumulative                                     kg/ha
                                                                                             root_mass_consum_cumul     CRTM               Root mass consumed, cumulative                                     kg/ha
                                                                                             grain_mass_consum_cumul    CSDM               Grain mass consumed, cumulative                                    kg/ha
                                                                                             shell_mass_consum_cumul    CSHM               Shell mass consumed, cumulative                                    kg/ha
                                                                                             stem_mass_consum_cumul     CSTM               Stem mass consumed, cumulative                                     kg/ha
                                                                                             leaf_area_consumed_cumu    CLAI               Leaf area consumed or destroyed by pests or diseases, cumulative   m2/m2
                                                                                             grain_numb_consum_cumul    CSD#              Grain number consumed, cumulative                                  number/m2
                                                                                             shell_numb_consum_cumul    CSH#              Shell number consumed, cumulative                                  number/m2
                                                                                             lodging_percent              LDG%D              Percent lodging                                                    %


