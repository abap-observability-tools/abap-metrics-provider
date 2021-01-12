# framework

## customizing

transaction ZAMP_CONFIG

![customizing example provider](./img/customizing_example_scenario.png)

![ustomizing example provider](./img/customizing_example_provider.png)

## compontent provider

### modul collector

## compontent scrapper

### modul converter

The converter get the scenario from the URL parameter `scenario`.
The URL should look like `http://vhcalnplci:8000/amp/metrics?sap-client=001&scenario=test`

# metrics

The collectors classes are marked with a C e.g. zcl_amp_c_runtime_errors.

## runtimte errors (ST22)

[zcl_amp_c_runtime_errors](../src/zamp_collector/zcl_amp_c_runtime_errors.clas.abap)

Selects all runtime errors from the table SNAP for the current Day.

## jobs (SM37)

[zcl_amp_c_jobs](../src/zamp_collector/zcl_amp_c_jobs.clas.abap)

Selects all jobs for the current Day and create a metric for each status.

## workloads (ST03N)

[zcl_amp_c_workloads](../src/zamp_collector/zcl_amp_c_workloads.clas.abap)

Select the workload of the system.

## SQL monitor data (SQLM)

[zcl_amp_c_sql_monitor](../src/zamp_collector/zcl_amp_c_sql_monitor.clas.abap)

Selects the sum of total DB time for the top five statements in the last hour.
