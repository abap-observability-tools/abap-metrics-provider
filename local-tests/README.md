# docker-abap-metrics-provider-tester

For testing metrics from a sap-netweaver in a setup with InfluxDB, Telegraf and Grafana.

## influxdb utils

curl -G http://localhost:8086/query?pretty=true --data-urlencode "db=glances" --data-urlencode "q=SHOW DATABASES"

curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE influxdb'

curl -G http://localhost:8086/query?pretty=true --data-urlencode "db=influxdb" --data-urlencode "q=SHOW MEASUREMENTS"

curl -G 'http://localhost:8086/query' --data-urlencode 'q=select * from influxdb..http'

curl -G 'http://localhost:8086/query' --data-urlencode 'q=select shortdumps_number_of_shortdumps from influxdb..http where time > now() - 1m' | jq .

## telegraf utils

telegraf --config telegraf.conf --test

docker run --rm telegraf telegraf config > telegraf_template.conf

## username/password for telegraf input plugins

The username/password will be passed via enviroment variables and docker to telegraf.conv.

```
export username=<<username>>
export password=<<password>>
```

## based on 
https://github.com/bcremer/docker-telegraf-influx-grafana-stack

https://github.com/nicolargo/docker-influxdb-grafana
