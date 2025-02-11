# Maykin Media charts

This repository contains Helm charts for:

- [openzaak](./charts/openzaak/README.md)
- [opennotificaties](./charts/opennotificaties/README.md)
- [openforms](./charts/openforms/README.md)
- [openinwoner](./charts/openinwoner/README.md)
- [openobjecten](./charts/objecten/README.md)
- [objecttypen](./charts/objecttypen/README.md)
- [openarchiefbeheer](./charts/openarchiefbeheer/README.md)
- [openklant](./charts/openklant/README.md)


```bash
helm repo add maykinmedia https://maykinmedia.github.io/charts/
helm search repo maykinmedia
helm install my-release maykinmedia/<chart>
```

## How to generate Readmes

To generate the charts readmes, we use [helm-docs](https://github.com/norwoodj/helm-docs).
To use it, first install Go and then follow their instructions on how to install it.
Then, within a chart directory you can run:

```bash 
helm-docs .
```
