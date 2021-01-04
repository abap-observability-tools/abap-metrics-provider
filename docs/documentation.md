# framework

## customizing

## compontent provider

### modul collector

## compontent scrapper

### modul converter

The converter get the scenario from the URL parameter `scenario`.
The URL should look like `http://vhcalnplci:8000/amp/metrics?sap-client=001&scenario=test`

# metrics

The collectors classes are marked with a C e.g. zcl_amp_c_runtime_errors.

## runtimte errors (ST22)

zcl_amp_c_runtime_errors

Selects all runtime errors from the table SNAP for the current Day.

```ABAP
    SELECT COUNT( * )
    INTO @DATA(number_of_runtime_errors)
    FROM snap
    WHERE datum = @sy-datum
    AND   seqno = '000'.

    metrics = VALUE #( BASE metrics ( metric_key = 'runtime_errors' metric_value = number_of_runtime_errors ) )
```

## jobs (SM37)

zcl_amp_c_jobs

Selects all jobs for the current Day and create a metric for each status.

```ABAP
    SELECT
    COUNT(*) AS count,
    status AS status
    FROM v_op
    INTO TABLE @DATA(jobs)
    WHERE strtdate = @sy-datum
    GROUP BY status.

    LOOP AT jobs ASSIGNING FIELD-SYMBOL(<job>).

      "status from include LBTCHDEF
      status = SWITCH #( <job>-status
                          WHEN 'R' THEN 'running'
                          WHEN 'Y' THEN 'ready'
                          WHEN 'P' THEN 'scheduled'
                          WHEN 'P' THEN 'intercepted'
                          WHEN 'S' THEN 'released'
                          WHEN 'A' THEN 'aborted'
                          WHEN 'F' THEN 'finished'
                          WHEN 'Z' THEN 'put_active'
                          WHEN 'X' THEN 'unknown_state'
                          ELSE 'no status found' ).

      metrics = VALUE #( BASE metrics ( metric_key = |jobs_{ status }| metric_value = <job>-count ) ).

    ENDLOOP.
```
