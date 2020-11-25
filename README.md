# abap-metrics-provider :construction: WIP

[![Known Vulnerabilities](https://snyk.io/test/github/Goala/abap-metrics-provider/badge.svg?targetFile=package.json)](https://snyk.io/test/github/Goala/abap-metrics-provider?targetFile=package.json)
![Run abaplint](https://github.com/Goala/abap-metrics-provider/workflows/Run%20abaplint/badge.svg)

# architecture

## component diagramm

![component diagramm](out/architecture/architecture_component/component_diagram.png)

## class diagramm

### provider

![class diagramm provider](out/architecture/architecture_class/provider.png)

### converter

![class diagramm converter](out/architecture/architecture_class/converter.png)

# documentation

## customizing

## compontent provider

### modul collector

## compontent scrapper

### modul converter

The converter get the scenario from the URL parameter `scenario`.
The URL should look like `http://vhcalnplci:8000/amp/metrics?sap-client=001&scenario=test`

# local tests

https://github.com/JohannesKonings/docker-abap-metrics-provider-tester

# based on
https://github.com/pacroy/abap-prometheus
