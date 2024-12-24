# This is collection of intree helm charts


You can find charts in charts folder and oci images for every chart in github packages.

## How to use (example)
#### yaml rendering
```bash
helm template oci://ghcr.io/intreecom/charts/py-app --version 0.1.0
```
#### show chart values
```bash
helm show values oci://ghcr.io/intreecom/charts/py-app --version 0.1.0
```
#### install chart
```bash
helm install py-app oci://ghcr.io/intreecom/charts/py-app --version 0.1.0
```
