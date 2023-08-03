# oam3-definitions

Repository to maintain OAM3 entity definitions

* Component definitions
  * [StatefulService](component/statefulservice.yaml): Component to create a statefulset. For now, only an empty dir volume is created.
  * [Deploy-from-git](component/deploy-git-app.yaml): Component to be able to deploy code from a git repository without the need to create a dockerfile or build a container first.
  * [Deno Runner](component/deno-runner.componentdefinition.yaml): Component to be able to deploy denos from a git repository.
* Trait definitions
  * [Gateway](trait/gateway.napptive.yaml): Make the default gateway trait compatible with Napptive
  * [Init container](trait/init-container.yaml): Updated init container trait
  * [Kubeconfig injector](trait/kubeconfig-injector.yaml): Inject the kubeconfig in a component to be able to execute kubectl commands on the same environment.
  * [Security context](trait/security-context.yaml): Modify the security context of the underlying component
  * [Storage](trait/storage.yaml): Updated storage trait

To add any definition to your system, create them in the `vela-system` namespace. For example:

```bash
kubectl -n vela-system create -f component/statefulservice.yaml
```

## License

Copyright 2023 Napptive

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.