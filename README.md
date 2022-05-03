# oam3-definitions

Repository to maintain OAM3 entity definitions

*[statefulservice.yaml](./componentdefintions/statefulservice.yaml): ComponentDefinition to create a statefulset. For now, only an empty dir volume is created.

Add the component defintion to vela-system namespace.

```bash
k -n vela-system create -f componentdefintions/statefulservice.yaml
```
