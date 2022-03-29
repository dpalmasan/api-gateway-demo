# Api Gateway demo

This project has my `krakend.json` file to the Blog Post microservice personal project. The microservices used are:

* [TextStat Service](https://github.com/dpalmasan/texstat-service)
* [BlogPost Service](https://github.com/dpalmasan/python-user-posts-microservice)
* [Authentication Service](https://github.com/dpalmasan/python-user-posts-microservice)

# Custom Plugin for Auth Logic

A custom plugin to validate tokens are not revoked is needed. Such a token can be found under `jwt_revoked_checker` directory. While developing the plugin, I ran into the following issue: `plugin was built with a different version of package`. To address this, I had to build `KrakenD` on my machine and run that version of `KrakenD`. I also made sure that libraries and compiling options matched the ones in the `Makefile`.

# JWT Validation

Some of the endpoints might be protected, for more information see [JWT validation](https://www.krakend.io/docs/authorization/jwt-validation/) on `krakend` docs. To create a secret with your `jwks`:

```
kubectl create secret generic jwks -n default --from-file=./jwks.json
```

Create a new deployment using the following command:

```
# To the default namespace
helm \
    --kube-context=minikube \
    upgrade --install --force --recreate-pods \
    api-gateway \
    helm
```

To forward port for development purposes:

```
kubectl port-forward service/krakend-service 7080:8000
```