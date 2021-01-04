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

## runtimte errors

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
