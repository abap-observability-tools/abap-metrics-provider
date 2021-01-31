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

## transactional RFCs (SM58)

[zcl_amp_c_transactional_rfcs](../src/zamp_collector/zcl_amp_c_transactional_rfcs.clas.abap)

Selects the transactional RFCs for the current Day and create a metric for each status.

## queued RFCs (SMQ1/SMQ2)

[zcl_amp_c_queued_rfcs](../src/zamp_collector/zcl_amp_c_queued_rfcs.clas.abap)

Selects the queued RFCs (inbound and outbound) for the current Day and create a metric for each status.

## transport states (STMS)

[zcl_amp_c_transport_states](../src/zamp_collector/zcl_amp_c_transport_states.clas.abap)

Selects the transport states for the current Day and create a metric for command and return code.

## Business Application Log (BAL)

[zcl_amp_c_bal_logs](../src/zamp_collector/zcl_amp_c_bal_logs.clas.abap)

Counts all logs for the current day and groups by Object and Subobject. 
Also provides the number of different message types per Bal Object.

## Batch Input Jobs (SM35)

[zcl_amp_c_batch_input](../src/zamp_collector/zcl_amp_c_batch_input.clas.abap)

Collect count of batch sessions for the current day.

## Batch Input Jobs (SM50/SM51)

[zcl_amp_c_work_processes](../src/zamp_collector/zcl_amp_c_work_processes.clas.abap)

Collect count of all work process types of all servers